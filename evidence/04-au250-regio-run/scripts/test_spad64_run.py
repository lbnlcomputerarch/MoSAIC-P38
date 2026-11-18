"""Offline tests for spad64_run.py against a mock with RV_AXIInD semantics.

The mock reproduces the hardware finding from run 07 attempt 1: the
read-data capture latches on the command pulse using the PREVIOUS
command's address snapshot, so a single OP_READ returns stale data.
The corrected double-OP_READ read in spad64_run must return mem[addr]
on the first call, every call.

Run: python3 test_spad64_run.py   (exit 0 = all tests passed)
"""
import contextlib
import io
import os
import sys
import types

HERE = os.path.dirname(os.path.abspath(__file__))
REGIO_DIR = "/tmp/opencode/regio"
LOCAL_HEX = ("/home/ffard/.local/share/opencode/worktree/25fb6b/"
             "pico64-au250-bitstream/tools/picorv_c/c64/pico64_scratchpad32.hex")

sys.path.insert(0, REGIO_DIR)
sys.path.insert(0, HERE)

try:
    import numpy  # noqa: F401
except ImportError:
    sys.modules["numpy"] = types.ModuleType("numpy")

import spad64_run  # noqa: E402
from spad64_run import RunError  # noqa: E402

CAFE = 0xCAFECACECAFECACE
F00D = 0xF00DF00DF00DF00D
IT = 16


class MockTile:
    def __init__(self):
        self.regs = {"readData_Status": 0, "readData_Command": 0,
                     "readData_Addr": 0, "readData_Data": 0,
                     "readData_Coordinates": 0,
                     "readData_RxPacketCount": 0, "readData_RxByteCount": 0}
        self.mem = [0] * 4096
        self.pending_addr = 0    # address snapshot the NEXT command captures
        self.data_observed = 0   # what a host read of readData_Data returns
        self.rv_control = 0
        self.filled = False


class MockRegIO:
    """Register-level mock of the 2x2 tilereg system with the real
    one-cycle-late address/data latch semantics of RV_AXIInD."""

    def __init__(self):
        self.tiles = {}
        for (r, c) in [(0, 0), (0, 1), (1, 0), (1, 1)]:
            self.tiles["tilereg%d_%d" % (r, c)] = MockTile()
        self.corrupt = None  # (block, addr, value) applied on fill

    def _parse(self, s):
        blk, reg = s.split(".", 1)
        return self.tiles[blk], reg

    def write_mem(self, s, v):
        t, reg = self._parse(s)
        if reg == "readData_Command":
            op = v & 0xFF
            # capture with the PREVIOUS command's address snapshot
            t.data_observed = t.mem[t.pending_addr & 0xFFF]
            t.pending_addr = t.regs["readData_Addr"]
            t.regs["readData_Command"] = v
            if op == spad64_run.OP_WRITE:
                t.mem[t.regs["readData_Addr"] & 0xFFF] = t.regs["readData_Data"]
                t.regs["readData_Status"] = 0xFF
            elif op == spad64_run.OP_READ:
                t.regs["readData_Status"] = 0xFF
            elif op == spad64_run.OP_STATUS:
                t.regs["readData_Status"] = t.rv_control
            elif op == spad64_run.OP_RISCV:
                new = t.regs["readData_Data"] & 0xFF
                if new == 1 and t.rv_control == 0 and not t.filled:
                    self._execute()
                t.rv_control = new
                t.regs["readData_Status"] = 0xFF
            else:
                raise AssertionError("unknown op %d" % op)
        else:
            t.regs[reg] = v
            if reg == "readData_Data":
                t.data_observed = v

    def read_mem(self, s):
        t, reg = self._parse(s)
        if reg == "readData_Data":
            return [t.data_observed]
        return [t.regs[reg]]

    def _execute(self):
        """Simulate the firmware run: fill the four pattern regions and
        bump the packet counters."""
        cafe_w = [(2 * i, (CAFE + i) & 0xFFFFFFFF) for i in range(IT)]
        cafe_w += [(2 * i + 1, ((CAFE + i) >> 32) & 0xFFFFFFFF) for i in range(IT)]
        f00d_w = [(2 * i, (F00D + i) & 0xFFFFFFFF) for i in range(IT)]
        f00d_w += [(2 * i + 1, ((F00D + i) >> 32) & 0xFFFFFFFF) for i in range(IT)]
        spad = self.tiles["tilereg0_1"]
        pico = self.tiles["tilereg0_0"]
        for (a, v) in cafe_w:
            spad.mem[0x100 + a] = v
            pico.mem[0x180 + a] = v
        for (a, v) in f00d_w:
            spad.mem[0x15A + a] = v
            pico.mem[0x1DA + a] = v
        if self.corrupt is not None:
            blk, addr, val = self.corrupt
            self.tiles[blk].mem[addr] = val
        pico.regs["readData_RxPacketCount"] = 0x40
        spad.regs["readData_RxPacketCount"] = 0x30
        self.filled = True


def naive_single_read(mrio, blk, waddr):
    """Replica of custom_functions_regIO.indirect_read_cb (the flaw)."""
    mrio.write_mem(blk + ".readData_Addr", waddr)
    mrio.write_mem(blk + ".readData_Command", spad64_run.OP_READ)
    return mrio.read_mem(blk + ".readData_Data")[0]


def run_capture(mrio, hex_path, out_dir):
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        rc = spad64_run.run(mrio, hex_path, out_dir)
    return rc, buf.getvalue()


def test_parse_hex():
    words = spad64_run.parse_hex(LOCAL_HEX)
    assert len(words) == 84, "expected 84 words, got %d" % len(words)
    assert words[0] == (0x000, 0x00004117), "first word %r" % (words[0],)
    addrs = [a for (a, _) in words]
    assert addrs == list(range(84)), "addresses not sequential"


def test_corrected_read_beats_stale_semantics():
    m = MockRegIO()
    t = m.tiles["tilereg0_0"]
    t.mem[7] = 0xABCD1234
    t.mem[8] = 0xDEAD5678
    # the naive single read is stale: after any prior command it returns
    # the PREVIOUS address's data
    stale1 = naive_single_read(m, "tilereg0_0", 7)
    assert stale1 != 0xABCD1234, "mock does not reproduce stale semantics"
    # the corrected read is right on the first call, for every call
    pico = spad64_run.TILE_BY_NAME["pico64"]
    for a in (7, 8, 7):
        v = spad64_run.indirect_read32(m, pico, a)
        assert v == t.mem[a], "corrected read of %d got 0x%x want 0x%x" % (
            a, v, t.mem[a])


def test_full_run_pass(tmp="/tmp/opencode/regio-run/out_pass"):
    m = MockRegIO()
    os.makedirs(tmp, exist_ok=True)
    rc, out = run_capture(m, LOCAL_HEX, tmp)
    assert rc == 0, "run() returned %d\n%s" % (rc, out)
    assert "RUNNER_RESULT: PASS values=64/64 regions=4/4" in out, out
    assert "program readback verified (84 words)" in out, out
    assert "PKTCNT tile00=0x00000040 tile01=0x00000030" in out, out
    for (name, _, _, _) in spad64_run.REGIONS:
        path = os.path.join(tmp, name + ".hex")
        lines = open(path).read().splitlines()
        assert len(lines) == IT, "%s: %d lines" % (name, len(lines))
        assert all(l.split()[-1] == "PASS" for l in lines), path
    # coordinates + release state on the mock
    assert m.tiles["tilereg0_0"].regs["readData_Coordinates"] == 0x00
    assert m.tiles["tilereg0_1"].regs["readData_Coordinates"] == 0x08
    assert m.tiles["tilereg1_0"].regs["readData_Coordinates"] == 0x01
    assert m.tiles["tilereg1_1"].regs["readData_Coordinates"] == 0x09
    assert m.tiles["tilereg0_0"].rv_control == 1


def test_full_run_detects_corruption(tmp="/tmp/opencode/regio-run/out_fail"):
    m = MockRegIO()
    m.corrupt = ("tilereg0_1", 0x102, 0xDEADBEEF)  # spad mput value j=1 low
    os.makedirs(tmp, exist_ok=True)
    rc, out = run_capture(m, LOCAL_HEX, tmp)
    assert rc == 1, "corrupted run must fail, got %d\n%s" % (rc, out)
    assert "RUNNER_RESULT: FAIL values=63/64 regions=3/4" in out, out
    fail_lines = [l for l in open(os.path.join(tmp, "tile01_mput.hex"))
                  if l.split()[-1] == "FAIL"]
    assert len(fail_lines) == 1, fail_lines
    assert fail_lines[0].split()[0] == "0x102", fail_lines[0]
    assert "0xdeadbeef" in fail_lines[0], fail_lines[0]


def test_program_verify_failstop(tmp="/tmp/opencode/regio-run/out_prog"):
    m = MockRegIO()
    # a stuck-at write: OP_WRITE never lands (simulated by corrupting the
    # mock's write path for one address)
    orig_write_mem = m.write_mem

    def stuck_write(s, v):
        t, reg = m._parse(s)
        if reg == "readData_Command" and (v & 0xFF) == spad64_run.OP_WRITE \
                and t.regs["readData_Addr"] == 0x010 and \
                t.regs["readData_Data"] == [w for (a, w) in
                                            spad64_run.parse_hex(LOCAL_HEX)
                                            if a == 0x010][0]:
            t.regs["readData_Status"] = 0x00  # command not accepted
            t.data_observed = t.mem[t.pending_addr & 0xFFF]
            t.pending_addr = t.regs["readData_Addr"]
            return
        orig_write_mem(s, v)
    m.write_mem = stuck_write
    os.makedirs(tmp, exist_ok=True)
    buf = io.StringIO()
    try:
        with contextlib.redirect_stdout(buf):
            spad64_run.run(m, LOCAL_HEX, tmp)
        raise AssertionError("stuck write must raise RunError")
    except RunError as e:
        assert "0x010" in str(e), str(e)


def main():
    tests = [test_parse_hex,
             test_corrected_read_beats_stale_semantics,
             test_full_run_pass,
             test_full_run_detects_corruption,
             test_program_verify_failstop]
    failed = 0
    for t in tests:
        try:
            t()
            print("PASS %s" % t.__name__)
        except AssertionError as e:
            failed += 1
            print("FAIL %s: %s" % (t.__name__, e))
        except Exception as e:  # noqa: BLE001
            failed += 1
            print("ERROR %s: %r" % (t.__name__, e))
    print("%d/%d tests passed" % (len(tests) - failed, len(tests)))
    return 1 if failed else 0


if __name__ == "__main__":
    spad64_run.RUN_SLEEP = 0.0
    sys.exit(main())
