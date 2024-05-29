/*
 * pcimem.c: Simple program to read/write from/to a pci device from userspace.
 *
 *  Copyright (C) 2010, Bill Farrow (bfarrow@beyondelectronics.us)
 *
 *  Based on the devmem2.c code
 *  Copyright (C) 2000, Jan-Derk Bakker (J.D.Bakker@its.tudelft.nl)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <signal.h>
#include <fcntl.h>
#include <ctype.h>
#include <termios.h>
#include <sys/types.h>
#include <sys/mman.h>

#define PRINT_ERROR \
	do { \
		fprintf(stderr, "Error at line %d, file %s (%d) [%s]\n", \
		__LINE__, __FILE__, errno, strerror(errno)); exit(1); \
	} while(0)

int fd;
void *map_base, *virt_addr;
off_t target, target_base;
int type_width = 4;
int map_size = 4096UL;
uint64_t read_result, writeval, prev_read_result = 0;
int items_count = 1;
int i;

int pcimem_device_open () {
	char pci_path[] = "/sys/devices/pci0000:d7/0000:d7:00.0/0000:d8:00.0/resource2";	     
	//char pci_path[] = "/sys/devices/pci0000:00/0000:00:02.5/0000:06:00.0/resource2";	     
	//	int fd;
	void *map_base, *virt_addr;
	uint64_t read_result, writeval, prev_read_result = 0;
	char *filename;
	off_t target, target_base;
	int access_type = 'w';
	int items_count = 1;
	int verbose = 0;
	int read_result_dupped = 0;
	int type_width;
	int i;
	int map_size = 4096UL;
	printf("Opening pcimem device");
        if((fd = open(pci_path, O_RDWR | O_SYNC)) == -1) PRINT_ERROR;
	//sleep(1);
}

int pcimem_device_close() {
	printf("Closing pcimem device");
  if(munmap(map_base, map_size) == -1) PRINT_ERROR;
  //sleep(1);
  close(fd);
}   

void pcimem_device_write(uint32_t address, uint32_t data) {
  //if (data == (uint32_t)0x00000000) {    
  //  return;
  //}
  printf("Writing to pcimem device: ");
  //address += 0x14000;
  off_t target, target_base;
  target = (off_t)address;
  int type_width = 4;
  target_base = target & ~(sysconf(_SC_PAGE_SIZE)-1);
  if (target + items_count*type_width - target_base > map_size)
	map_size = target + items_count*type_width - target_base;

  map_base = mmap(0, map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, target_base);
  if (map_base != MAP_FAILED) {
    virt_addr = map_base + target + i*type_width - target_base;
    //read_result = *((uint32_t *) virt_addr);
    //printf("Value at offset 0x%X (%p): 0x%0*lX\n", (int) target + i*type_width, virt_addr, type_width*2, read_result);
    //fflush(stdout);
  //	sleep(1);
  
    *((uint32_t *) virt_addr) = data;
    //read_result = *((uint32_t *) virt_addr);
    //    printf("Written 0x%0*lX; readback 0x%*lX\n", type_width, data, type_width, read_result);
    printf("Wrote 0x%0*lX to 0x%X;\n", type_width*2, data, address);
    fflush(stdout);

  }
  if(munmap(map_base, map_size) == -1) PRINT_ERROR;
  //sleep(1);
}

uint32_t pcimem_device_read(uint32_t address, uint32_t *data) {

  printf("Reading from pcie device");

  //address += 0x14000;
  off_t target, target_base;
  target = (off_t)address;
  int type_width = 4;
  target_base = target & ~(sysconf(_SC_PAGE_SIZE)-1);
  if (target + items_count*type_width - target_base > map_size)
	map_size = target + items_count*type_width - target_base;


  map_base = mmap(0, map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, target_base);
  //sleep(1);
    if (map_base != MAP_FAILED) {

    virt_addr = map_base + target + i*type_width - target_base;
    data = *((uint32_t *) virt_addr);
    printf("Value at offset 0x%X (%p): 0x%0*lX\n", (int) target + i*type_width, address, type_width*2, data);
    fflush(stdout);

  }
  if(munmap(map_base, map_size) == -1) PRINT_ERROR;
  //sleep(1);
  return data;
}


int pcimem_device_open_exp () {
	char pci_path[] = "/sys/devices/pci0000\:d7/0000\:d7\:00.0/0000\:d8\:00.0/resource2";	     
	//	int fd;
	void *map_base, *virt_addr;
	uint64_t read_result, writeval, prev_read_result = 0;
	char *filename;
	off_t target, target_base;
	int access_type = 'w';
	int items_count = 1;
	int verbose = 0;
	int read_result_dupped = 0;
	int type_width;
	int i;
	int map_size = 4096UL;
	printf("Opening pcimem device");
        if((fd = open(pci_path, O_RDWR | O_SYNC)) == -1) PRINT_ERROR;

  
	//  uint32_t base_address = 0x10000;
  uint32_t base_address = 0x40000;
  target = (off_t)base_address;
  target_base = target & ~(sysconf(_SC_PAGE_SIZE)-1);
  if (target + items_count*type_width - target_base > map_size)
	map_size = target + items_count*type_width - target_base;

  map_base = mmap(0, map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, target_base);

}

int pcimem_device_close_exp() {
  printf("Closing pcie device");
  if(munmap(map_base, map_size) == -1) PRINT_ERROR;
  close(fd);
}   

void pcimem_device_write_exp(uint32_t address, uint32_t data) {
  printf("Writing to pcimem device");
  virt_addr = map_base + address + target + 1*type_width - target_base;
  *((uint32_t *) virt_addr) = data;
  //  read_result = *((uint32_t *) virt_addr);
  printf("Written 0x%0*lX; data 0x%*lX\n", type_width, data);
  fflush(stdout);
}

void pcimem_device_read_exp(uint32_t address, uint32_t *data) {

  printf("Reading from pcimem device");
  virt_addr = map_base + address+ target + 1*type_width - target_base;
  data = *((uint32_t *) virt_addr);
  printf("Value at offset 0x%X (%p): 0x%0*lX\n", (int) target + i*type_width, virt_addr, type_width*2, data);
  fflush(stdout);

}

