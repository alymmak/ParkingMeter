`timescale 1ns / 1ps
module debounce_mod(
                    input clk, 
                    input PB,
                    output reg PB_state
                    );

 //Synchronize the switch input to the clock 
 reg [15:0] sync_counter;
 reg first_sync;
 always @(posedge clk) first_sync <= PB;
 reg second_sync;
 always @(posedge clk) PB_state <=first_sync;
 
// //Debounce the switch
// always @(posedge clk)
// if(PB_state == second_sync)
//    sync_counter <=0;
// else
// begin 
//    sync_counter <= sync_counter + 1'b1;
//    if(sync_counter == 16'hffff) PB_state <= ~PB_state;
// end
endmodule
