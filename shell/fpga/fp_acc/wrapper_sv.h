// *************************************************************************
// 
// *** Copyright Notice ***
//
// P38 heterogeneous multi-tiled system with support for message queues 
// (MoSAIC) Copyright (c) 2024, The Regents of the University of California, 
// through Lawrence Berkeley National Laboratory (subject to receipt of
// any required approvals from the U.S. Dept. of Energy). All rights reserved.
// 
// If you have questions about your rights to use or distribute this software,
// please contact Berkeley Lab's Intellectual Property Office at
// IPO@lbl.gov.
//
// NOTICE.  This Software was developed under funding from the U.S. Department
// of Energy and the U.S. Government consequently retains certain rights.  As
// such, the U.S. Government has been granted for itself and others acting on
// its behalf a paid-up, nonexclusive, irrevocable, worldwide license in the
// Software to reproduce, distribute copies to the public, prepare derivative 
// works, and perform publicly and display publicly, and to permit others 
// to do so.
//
// *************************************************************************

//- This below only necessary for system-verilog simulation
//  and not when working with the FPGA
//# include "CAM.h"
//# include "svdpi.h"
//# include "dpi.h"

typedef uint32_t addr_t;

// ******************************************************

// User-level wrapper functions for SV
// NOTE: needed to provide an function pointer for context
// NOTE: and link to SV function by name

uint32_t SUCCESS = 255;
uint32_t FAILURE = -1;

uint32_t tileBase = 0x100000;

///////////////////////////////////
// FUNCTION: 1) register_write_control_mytable
///////////////////////////////////
void register_write_control_mytable(addr_t Addr, uint32_t Data) {
  pcimem_device_write(tileBase+Addr, Data);
}

///////////////////////////////////
// FUNCTION: 2) register read_control_mytable
///////////////////////////////////
uint32_t register_read_control_mytable(addr_t Addr) {
  uint32_t data;
  return pcimem_device_read(tileBase+Addr, &data);
}

///////////////////////////////////
// FUNCTION: 3) indirect_write
///////////////////////////////////
uint32_t indirect_write(addr_t BaseAddr, uint32_t Addr, uint32_t Data) {
  uint32_t write_op = 1;
  uint32_t status_offset = 0x0;
  uint32_t command_offset = 0x4;
  uint32_t address_offset = 0x8;
  uint32_t data_offset = 0xc;
  uint32_t data;
  uint32_t tmp_data;

  register_write_control_mytable((addr_t)(BaseAddr+address_offset), Addr);
  register_write_control_mytable((addr_t)(BaseAddr+data_offset), Data);
  register_write_control_mytable((addr_t)(BaseAddr+command_offset), write_op);
  tmp_data = pcimem_device_read(tileBase+BaseAddr+status_offset, &data);
  if (tmp_data == SUCCESS)
    return SUCCESS;
  else
    return FAILURE;
  return SUCCESS;
}

///////////////////////////////////
// FUNCTION: 4) indirect_read
///////////////////////////////////
uint32_t indirect_read(addr_t BaseAddr, uint32_t Addr) {
  uint32_t read_op = 2;
  uint32_t status_offset = 0x0;
  uint32_t command_offset = 0x4;
  uint32_t address_offset = 0x8;
  uint32_t data_offset = 0xc;
  uint32_t data;
  uint32_t tmp_data;
  
  register_write_control_mytable((addr_t)(BaseAddr+address_offset), Addr);
  register_write_control_mytable((addr_t)(BaseAddr+command_offset), read_op);
  tmp_data = pcimem_device_read(tileBase+BaseAddr+status_offset, &data);
  if (tmp_data == SUCCESS)
    return  register_read_control_mytable((addr_t)(BaseAddr+data_offset));
  else
    return FAILURE;
}

///////////////////////////////////
// FUNCTION: 5) rvGetStatus
///////////////////////////////////
uint32_t rvGetStatus(addr_t BaseAddr) {
  uint32_t status_op = 3;
  uint32_t status_offset = 0x0;
  uint32_t command_offset = 0x4;
  uint32_t address_offset = 0x8;
  uint32_t data_offset = 0xc;

  register_write_control_mytable((addr_t)(BaseAddr+address_offset), 0x0);
  register_write_control_mytable((addr_t)(BaseAddr+command_offset), status_op);
  return register_read_control_mytable((addr_t)(BaseAddr+status_offset));
}

///////////////////////////////////
// FUNCTION: 6) rvSetStatus
///////////////////////////////////
uint32_t rvSetStatus(addr_t BaseAddr, uint32_t Data) {
  uint32_t rv_op = 4;
  uint32_t status_offset = 0x0;
  uint32_t command_offset = 0x4;
  uint32_t address_offset = 0x8;
  uint32_t data_offset = 0xc;

  register_write_control_mytable((addr_t)(BaseAddr+address_offset), 0x0);
  register_write_control_mytable((addr_t)(BaseAddr+data_offset), Data & 0xFF);
  register_write_control_mytable((addr_t)(BaseAddr+command_offset), rv_op);

  return rvGetStatus(BaseAddr);
}

///////////////////////////////////
// FUNCTION: 7) rvLoadFirmware
///////////////////////////////////
uint32_t rvLoadFirmware(addr_t BaseAddr, char * hexfile) {
   FILE *fptr;
   char *line = NULL;
   size_t len = 0;
   ssize_t read;
   uint32_t addr = 0;
   uint32_t data = 0;
   uint32_t rdata = 0;

   fptr = fopen(hexfile,"r");
   if (fptr == NULL) {
      printf("[SW] Test from DPI-C: Error! opening file\n");
      return (EXIT_FAILURE);
   }
   printf("[SW] Test from DPI-C: Successfully opened firmware\n");

   while ((read = getline(&line, &len, fptr)) != -1) {
      if (line[0] == '@') {
         addr = (uint32_t)strtol(line+1, NULL, 16);
         printf("[SW] Test from DPI-C: Setting addr 0x%08X\n", addr);
      }else {
         data = (uint32_t)strtol(line, NULL, 16);
         printf("[SW] Test from DPI-C: Setting data 0x%08X at addr 0x%08X\n", data, addr);
         rdata = indirect_write(BaseAddr, addr, data);
         if (rdata != 0xFF) {
            printf("[SW] Test from DPI-C: Error! Firmware readback mismatch\n");
            return (EXIT_FAILURE);
         }
         //addr += 4;
         addr += 1;
      }
   }
   printf("[SW] Test from DPI-C: Successfully finished loading firmware\n");
   fclose(fptr);
   if (line) {
      free(line);
   }

   //- LPGG
   register_write_control_mytable((addr_t)(BaseAddr+0x4), 0x0);

   return EXIT_SUCCESS;
}

