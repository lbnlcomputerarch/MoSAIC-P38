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

/* ////////////////////////////////////////////////////////////////
// Author      : Laura Kallem
// Date        : August 2025
// Description : TinyODIN tbench.sv file recreation.
// File        : pico_snn.c

// ///////////////////////////////////////////////////////////////*/

#include <stdlib.h>
#include "mq.h"

/*
        Running tbench full check, open and closed loop. 
        Neuron & Synapse verification skipped.
*/

#define phase             1
#define DO_OPEN_LOOP      0
#define DO_CLOSED_LOOP    1

/*
    NOTE: Because SPI sends happen seperately during the configuration stage, only tests that do AER sends right after all configurations are finished will work.
    EX: Closed loop test, Open loop test (phase 1 or phase 2 only)
*/

void main(int argc, char *argv[]) {

    // Get the tile id
    int tile_id = atoi(argv[1]);
    int j;
    int k;

    // testbench neurons
    int input_neurons[16]  = {255,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};

    uint32_t data;
   
   // MoDIN is tile 9 in the 2x2 array example, change accordingly for your own set up.
    uint32_t addr = 9;
    addr = (addr << 12);

    // OPEN LOOP
    if (DO_OPEN_LOOP) {
        // phase 1 
        if (!phase){
            data = 0x1FF;
            for (j=0; j<2050; j=j+1){
                mPut(data,addr);
            }
        }

        // phase 2
        if (phase){
            for (j=0; j<16; j=j+1){
                for(k=0; k<10; k=k+1){
                    data =  ((0 << 10) | (0 << 9) | (input_neurons[j] & 0xff));
                    mPut(data, addr);
                }
            }

            for (j=0; j<100; j=j+1){
                data = ( (0 << 10) | (1 << 9) | (0x1ff) );
                mPut(data, addr);
            }
            
            for(j=0; j<300; j=j+1){
                data = ( (0 << 10) | (0 << 9) | (input_neurons[7] & 0xff) );
                mPut(data, addr);
            }
        }
    }
    
    // CLOSED LOOP
    if (DO_CLOSED_LOOP){
        data = 0x253;  // Virtual value 5 event to neuron 3
        // phase 2
        if (phase){
            for (j=0; j<2; j=j+1){
                mPut(data,addr);
            }
        }
    }
}