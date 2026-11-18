/*
 * spad64_runner.c: one-off fixed-purpose runner for the authorized
 * 2026-11-18 AU250 full-scratchpad FPGA run.
 *
 * Evidence location: evidence/07-fpga-run-20261118T000500Z/scripts/
 * This file is run evidence, not repository code and not reusable
 * deployment logic.  The command sequence mirrors the tested legacy
 * pico_programming/set_system.c indirect-control flow, with a corrected
 * read path (reads return the loaded register value through the pointer).
 *
 * Usage: spad64_runner <resource2-path> <pico64_scratchpad32.hex> <outdir>
 *
 * Bitstream map (accepted bitstream, testcase mosaic_2x2_pico64_vivado,
 * TILE_TYPE 8'b00100111, axi_ux_addr_var.vh: 4 x 256 B control windows,
 * tile index k = i*COL+j decodes window k):
 *   BAR2 0x100000 + 0x000  grid(0,0)  pico64  coordinate 0x00 (TID_SELF)
 *   BAR2 0x100000 + 0x100  grid(0,1)  spad    coordinate 0x08 (TID_SPAD)
 *   BAR2 0x100000 + 0x200  grid(1,0)  loop    coordinate 0x01
 *   BAR2 0x100000 + 0x300  grid(1,1)  pico32  coordinate 0x09
 * Tile id = (col << 3) | row (pico64_scratchpad.c); the coordinate
 * register (0x10) provides HsrcId = {myY = coord[5:3], myX = coord[2:0]}.
 *
 * Indirect control plane (RV_AXIInD.v / TileRegBlock.v), offsets within a
 * tile window: status 0x0, command 0x4, word address 0x8, data 0xc,
 * coordinates 0x10, rx packet count 0x14.  Operations: 1 write, 2 read,
 * 3 status, 4 riscv.  Status reads 0xff after an accepted write/read
 * command; after a status command it mirrors rv_control.
 *
 * Expected regions (word32 addresses; 64-bit value i occupies the low
 * half at base+2i and the high half at base+2i+1):
 *   spad 0x100: 16 x (0xCAFECACECAFECACE + i)   mPut writes
 *   spad 0x15A: 16 x (0xF00DF00DF00DF00D + i)   remote stores
 *   pico 0x180: 16 x (0xCAFECACECAFECACE + i)   mGet responses
 *   pico 0x1DA: 16 x (0xF00DF00DF00DF00D + i)   remote load results
 */

#define _POSIX_C_SOURCE 200809L

#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

#define TILE_BASE   UINT32_C(0x100000)
#define TILE_PICO   (TILE_BASE + UINT32_C(0x000))
#define TILE_SPAD   (TILE_BASE + UINT32_C(0x100))
#define TILE_LOOP   (TILE_BASE + UINT32_C(0x200))
#define TILE_PICO32 (TILE_BASE + UINT32_C(0x300))

#define REG_STAT    UINT32_C(0x0)
#define REG_CMND    UINT32_C(0x4)
#define REG_ADDR    UINT32_C(0x8)
#define REG_DATA    UINT32_C(0xc)
#define REG_COORD   UINT32_C(0x10)
#define REG_PKTCNT  UINT32_C(0x14)

#define OP_WRITE    UINT32_C(1)
#define OP_READ     UINT32_C(2)
#define OP_STATUS   UINT32_C(3)
#define OP_RISCV    UINT32_C(4)

#define STATUS_OK   UINT32_C(0xff)

#define COORD_PICO   UINT32_C(0x00)
#define COORD_SPAD   UINT32_C(0x08)
#define COORD_LOOP   UINT32_C(0x01)
#define COORD_PICO32 UINT32_C(0x09)

#define PATTERN_MPUT  UINT64_C(0xCAFECACECAFECACE)
#define PATTERN_STORE UINT64_C(0xF00DF00DF00DF00D)

#define IT          16
#define MPUT_OFF    UINT32_C(0x100)
#define STORE_DELTA UINT32_C(90)
#define LOCAL_OFF   UINT32_C(0x180)
#define MAX_WORDS   4096

static volatile uint32_t *bar2;

static void die(const char *fmt, ...)
{
	va_list ap;

	fputs("spad64-runner: FAIL: ", stderr);
	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
	exit(1);
}

static void wr32(uint32_t addr, uint32_t value)
{
	bar2[addr / sizeof(uint32_t)] = value;
}

static uint32_t rd32(uint32_t addr)
{
	return bar2[addr / sizeof(uint32_t)];
}

static uint32_t indirect_read32(uint32_t tile, uint32_t waddr)
{
	uint32_t status;

	wr32(tile + REG_ADDR, waddr);
	wr32(tile + REG_CMND, OP_READ);
	status = rd32(tile + REG_STAT);
	if (status != STATUS_OK)
		die("indirect read word32 0x%03" PRIx32 " tile 0x%05" PRIx32
		    ": status 0x%08" PRIx32, waddr, tile, status);
	return rd32(tile + REG_DATA);
}

static void indirect_write32(uint32_t tile, uint32_t waddr, uint32_t wdata)
{
	uint32_t status;

	wr32(tile + REG_ADDR, waddr);
	wr32(tile + REG_DATA, wdata);
	wr32(tile + REG_CMND, OP_WRITE);
	status = rd32(tile + REG_STAT);
	if (status != STATUS_OK)
		die("indirect write word32 0x%03" PRIx32 " = 0x%08" PRIx32
		    " tile 0x%05" PRIx32 ": status 0x%08" PRIx32,
		    waddr, wdata, tile, status);
}

/* Mirror set_system rvSetStatus: rv op, then status op, then read status. */
static uint32_t rv_set_status(uint32_t tile, uint32_t value)
{
	wr32(tile + REG_ADDR, 0);
	wr32(tile + REG_DATA, value & 0xff);
	wr32(tile + REG_CMND, OP_RISCV);
	wr32(tile + REG_ADDR, 0);
	wr32(tile + REG_CMND, OP_STATUS);
	return rd32(tile + REG_STAT);
}

static void print_tile_state(const char *name, uint32_t tile)
{
	printf("PRE %-8s status=0x%08" PRIx32 " coord=0x%08" PRIx32
	       " pktcnt=0x%08" PRIx32 "\n", name,
	       rd32(tile + REG_STAT), rd32(tile + REG_COORD),
	       rd32(tile + REG_PKTCNT));
}

int main(int argc, char **argv)
{
	static uint32_t prog_addr[MAX_WORDS];
	static uint32_t prog_data[MAX_WORDS];
	const struct {
		const char *name;
		uint32_t tile;
		uint32_t coord;
	} coords[] = {
		{ "tile00", TILE_PICO,   COORD_PICO   },
		{ "tile01", TILE_SPAD,   COORD_SPAD   },
		{ "tile10", TILE_LOOP,   COORD_LOOP   },
		{ "tile11", TILE_PICO32, COORD_PICO32 },
	};
	const struct {
		const char *name;
		uint32_t tile;
		uint32_t base;
		uint64_t pattern;
	} regions[] = {
		{ "tile01_mput",  TILE_SPAD, MPUT_OFF, PATTERN_MPUT  },
		{ "tile01_store", TILE_SPAD, MPUT_OFF + STORE_DELTA,
		  PATTERN_STORE },
		{ "tile00_mget",  TILE_PICO, LOCAL_OFF, PATTERN_MPUT  },
		{ "tile00_load",  TILE_PICO, LOCAL_OFF + STORE_DELTA,
		  PATTERN_STORE },
	};
	const char *resource_path;
	const char *hex_path;
	const char *out_dir;
	struct stat st;
	char path[512];
	FILE *f;
	unsigned n_words = 0;
	uint32_t waddr = 0;
	uint32_t data;
	char line[256];
	size_t i;
	int j;
	int fd;
	int values_ok = 0;
	int regions_ok = 0;

	if (argc != 4) {
		fprintf(stderr, "usage: %s <resource2> <firmware.hex> <outdir>\n",
			argv[0]);
		return 2;
	}
	resource_path = argv[1];
	hex_path = argv[2];
	out_dir = argv[3];

	fd = open(resource_path, O_RDWR | O_SYNC);
	if (fd < 0)
		die("open %s: %s", resource_path, strerror(errno));
	if (fstat(fd, &st) != 0)
		die("fstat %s: %s", resource_path, strerror(errno));
	printf("resource2=%s size=%jd\n", resource_path, (intmax_t)st.st_size);
	bar2 = mmap(NULL, (size_t)st.st_size, PROT_READ | PROT_WRITE,
		    MAP_SHARED, fd, 0);
	if (bar2 == MAP_FAILED)
		die("mmap %s: %s", resource_path, strerror(errno));

	printf("== pre-state (direct reads)\n");
	print_tile_state("tile00", TILE_PICO);
	print_tile_state("tile01", TILE_SPAD);
	print_tile_state("tile10", TILE_LOOP);
	print_tile_state("tile11", TILE_PICO32);

	/* 1) hold the pico64 core in reset */
	data = rv_set_status(TILE_PICO, 0x00);
	printf("rvSetStatus(tile00, 0x00) -> 0x%02" PRIx32 "\n", data);
	if (data != 0x00)
		die("rv reset readback 0x%02" PRIx32 ", expected 0x00", data);

	/* 2) load the firmware through the indirect control plane */
	f = fopen(hex_path, "r");
	if (f == NULL)
		die("open %s: %s", hex_path, strerror(errno));
	while (fgets(line, sizeof line, f) != NULL) {
		if (line[0] == '@') {
			waddr = (uint32_t)strtoul(line + 1, NULL, 16);
			continue;
		}
		if (line[strspn(line, " \t\r\n")] == '\0')
			continue;
		if (n_words == MAX_WORDS)
			die("firmware larger than %d words", MAX_WORDS);
		data = (uint32_t)strtoul(line, NULL, 16);
		indirect_write32(TILE_PICO, waddr, data);
		prog_addr[n_words] = waddr;
		prog_data[n_words] = data;
		++n_words;
		++waddr;
	}
	fclose(f);
	printf("loaded %u word32 into tile00\n", n_words);
	if (n_words == 0)
		die("no words loaded from %s", hex_path);

	/* 3) read back and verify the loaded program */
	snprintf(path, sizeof path, "%s/tile00_program_readback.hex", out_dir);
	f = fopen(path, "w");
	if (f == NULL)
		die("open %s: %s", path, strerror(errno));
	for (i = 0; i < n_words; ++i) {
		uint32_t rb = indirect_read32(TILE_PICO, prog_addr[i]);

		fprintf(f, "0x%03x 0x%08x\n", prog_addr[i], rb);
		if (rb != prog_data[i])
			die("program readback word32 0x%03x: read 0x%08x, want 0x%08x",
			    prog_addr[i], rb, prog_data[i]);
	}
	fclose(f);
	printf("program readback verified (%u words) -> %s\n", n_words, path);

	/* 4) assign tile coordinates (identity used by the NoC routers) */
	for (i = 0; i < sizeof coords / sizeof coords[0]; ++i) {
		uint32_t rb;

		wr32(coords[i].tile + REG_COORD, coords[i].coord);
		rb = rd32(coords[i].tile + REG_COORD);
		printf("coord %-8s <- 0x%02" PRIx32 ", readback 0x%02" PRIx32
		       "\n", coords[i].name, coords[i].coord, rb);
		if (rb != coords[i].coord)
			die("coordinate readback mismatch for %s",
			    coords[i].name);
	}

	/* 5) release the pico64 core */
	data = rv_set_status(TILE_PICO, 0x01);
	printf("rvSetStatus(tile00, 0x01) -> 0x%02" PRIx32 "\n", data);
	if (data != 0x01)
		die("rv release readback 0x%02" PRIx32 ", expected 0x01", data);

	/* 6) wait for execution (set_system sleeps 2 s) */
	sleep(2);

	printf("== post-run packet counters\n");
	printf("PKTCNT tile00=0x%08" PRIx32 " tile01=0x%08" PRIx32 "\n",
	       rd32(TILE_PICO + REG_PKTCNT), rd32(TILE_SPAD + REG_PKTCNT));

	/* 7) read and check the four expected regions */
	for (i = 0; i < sizeof regions / sizeof regions[0]; ++i) {
		int region_pass = 1;

		snprintf(path, sizeof path, "%s/%s.hex", out_dir,
			 regions[i].name);
		f = fopen(path, "w");
		if (f == NULL)
			die("open %s: %s", path, strerror(errno));
		printf("== region %s (tile 0x%05x, word32 0x%03x..0x%03x)\n",
		       regions[i].name, regions[i].tile, regions[i].base,
		       regions[i].base + 2 * IT - 1);
		for (j = 0; j < IT; ++j) {
			uint32_t lo = indirect_read32(regions[i].tile,
			    regions[i].base + 2 * (uint32_t)j);
			uint32_t hi = indirect_read32(regions[i].tile,
			    regions[i].base + 2 * (uint32_t)j + 1);
			uint64_t got = ((uint64_t)hi << 32) | lo;
			uint64_t want = regions[i].pattern + (uint64_t)j;
			int ok = got == want;

			fprintf(f, "0x%03x 0x%08x 0x%08x 0x%016" PRIx64 " %s\n",
				regions[i].base + 2 * (uint32_t)j, lo, hi, got,
				ok ? "PASS" : "FAIL");
			printf("  [%2d] got 0x%016" PRIx64
			       " want 0x%016" PRIx64 " %s\n",
			       j, got, want, ok ? "PASS" : "FAIL");
			if (ok)
				++values_ok;
			else
				region_pass = 0;
		}
		fclose(f);
		if (region_pass)
			++regions_ok;
		printf("region %s: %s -> %s\n", regions[i].name,
		       region_pass ? "PASS" : "FAIL", path);
	}

	printf("RUNNER_RESULT: %s values=%d/%d regions=%d/4\n",
	       values_ok == 4 * IT ? "PASS" : "FAIL",
	       values_ok, 4 * IT, regions_ok);

	munmap((void *)bar2, (size_t)st.st_size);
	close(fd);
	return values_ok == 4 * IT ? 0 : 1;
}
