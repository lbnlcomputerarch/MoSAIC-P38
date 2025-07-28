#include <stdlib.h>
#include "mq.h"

/*
        Running tbench full check, open and closed loop. 
        Neuron & Synapse verification skipped.
*/

void main(int argc, char *argv[]) {
    // Get the tile id
    int tile_id = atoi(argv[1]);
    int j;
    int k;

    // testbench neurons
    int input_neurons[16]  = {255,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};

    uint32_t data = 0x253;

    uint32_t addr1 = 8;
    addr1 = (addr1 << 12);
    mPut(data, addr1);

   
    uint32_t addr = 9;
    addr = (addr << 12);

    // OPEN LOOP

    // phase 1 
    data = 0x1FF;
    for (j=0; j<2050; j=j+1){
        mPut(data,addr);
    }

    // phase 2
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

    
    // CLOSED LOOP

    data = 0x253;

    // phase 2
    for (j=0; j<2; j=j+1){
         mPut(data,addr);
    }

}

// patricia code
/*
uint32_t data_in [2];
data_in = (0x253,0x253);
modin_tile_id = 9; 
modin_base_addr = 9 << 12; 
for( j... ){
    mPut(moding_base_addr,data_in[j])
}
*/