`timescale 1ns / 1ps

module Top(CLK, BUTTON_U, BUTTON_L, BUTTON_R, BUTTON_D, RESET_10, RESET_205, an, sseg, dp, LED);
input CLK, BUTTON_U, BUTTON_L, BUTTON_R, BUTTON_D, RESET_10, RESET_205, LED; 
output [3:0] an;
output [6:0] sseg;
output dp;

wire[3:0] sec_out0;
wire[3:0] sec_out1;
wire[3:0] sec_out2;
wire[3:0] sec_out3;

wire two_clock;
wire one_clock;
wire one_clock_single_pulse;
wire show_clock;

wire out_buttonU;
wire out_buttonL;
wire out_buttonR;
wire out_buttonD;

wire out_buttonU_1;
wire out_buttonL_1;
wire out_buttonR_1;
wire out_buttonD_1;


wire[6:0] in0;
wire[6:0] in1, in2, in3;

twosec_clk c1(CLK, two_clock);
onesec_clk c2(CLK, one_clock);
show_clk c18(CLK, show_clock);

debounce_mod c3(show_clock, BUTTON_U, out_buttonU);
debounce_mod c4(show_clock, BUTTON_L, out_buttonL);
debounce_mod c5(show_clock, BUTTON_R, out_buttonR);
debounce_mod c6(show_clock, BUTTON_D, out_buttonD);

synch_input c7(CLK, out_buttonU, out_buttonU_1);
synch_input c8(CLK, out_buttonL, out_buttonL_1);
synch_input c9(CLK, out_buttonR, out_buttonR_1);
synch_input c10(CLK, out_buttonD, out_buttonD_1);

synch_input c20(CLK, one_clock, one_clock_single_pulse);

button_counter c11(CLK, one_clock_single_pulse, two_clock, out_buttonU_1, out_buttonL_1, out_buttonR_1, out_buttonD_1, RESET_10, RESET_205, sec_out0, sec_out1, sec_out2, sec_out3, LED);

hexto7segment c12(.x(sec_out0), .r(in0));
hexto7segment c13(.x(sec_out1), .r(in1));
hexto7segment c14(.x(sec_out2), .r(in2));
hexto7segment c15(.x(sec_out3), .r(in3));

clock_display c16(CLK, slow_clock);
display_board c17(slow_clock, in0, in1, in2, in3, an, sseg, dp);
endmodule
