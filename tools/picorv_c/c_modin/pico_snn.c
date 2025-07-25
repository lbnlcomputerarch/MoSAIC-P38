#include <stdlib.h>
// Remove this: #include <unistd.h> 
#include "mq.h"

#define N 256
#define M 8

#define DO_FULL_CHECK             1
#define     DO_OPEN_LOOP          0
#define     DO_CLOSED_LOOP        1

// Add this delay function
void delay_us(int microseconds) {
    // Simple busy-wait delay - adjust multiplier as needed for your clock frequency
    volatile int i;
    for (i = 0; i < microseconds * 100; i++) {
        // Burn cycles
    }
}

void main(int argc, char *argv[]) {
    // Get the tile id
    int tile_id = atoi(argv[1]);

    int target_neurons[16] = {255,250,248,194,169,140,119,100,62,53,38,27,13,3,1,0};
    int input_neurons[16]  = {255,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0};

    // modin is tile 1
    // 0x00001000
    uint32_t addr = 0x00001000;
    uint32_t data = 0;

    int j;
    int k;

    _Bool phase = 1; // false phase 1, true phase 2


// FIXME: ignored for now
    if (DO_OPEN_LOOP) {
        if (!phase) {  // phase 1
            data = ( 0x1FF );

            for (j=0; j<2050; j=j+1) {
                mPut(addr,data);
            }
        }

        phase = 1;
        if (phase){
            for (j=0; j<16; j=j+1) {
                for (k=0; k<10; k=k+1) {              
                    data =  ( (0 << 10) | (0 << 9) | (input_neurons[j] & 0xff) );
                    mPut(addr, data);
                    delay_us(2);  // Replace usleep(2)
                }
            }
        
            delay_us(10);  // Replace usleep(10)
            
            for (j=0; j<100; j=j+1){
                data = ( (0 << 10) | (1 << 9) | (0xff));
                mPut(addr, data);
                delay_us(2);  // Replace usleep(2)
            }

            delay_us(10);  // Replace usleep(10)

            for (j=0; j<300; j=j+1){
                data =  ( (0 << 10) | (0 << 9) | (input_neurons[7] & 0xff) );
                mPut(addr, data);
                delay_us(2);  // Replace usleep(2)
            }
        }
    }

    if (DO_CLOSED_LOOP) {
        // phase 2 only
        if (phase) {
            data = 0x253;
            
            for (j=0; j<2; j=j+1){
                mPut(addr, data);
            }
        }
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