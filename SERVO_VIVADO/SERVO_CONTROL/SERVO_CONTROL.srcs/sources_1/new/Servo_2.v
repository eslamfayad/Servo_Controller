/*
  Output a single pwm signal with period of ~20ms
   Pulse width = 1ms -> 2ms full scale. 1.5ms is center position
*/
`timescale 1ns / 1ps
module Servo_2 (
  input clk_120,
  input rst,
  input  mode_sel,
  input  [7:0] switchs,
  output [7:0] leds,
 // output  [20:0]Seven_segment,
  output servo2,
  output servo
  );
  wire [20:0] Seven_segment;
  wire[7:0] position;
  reg pwm_q,pwm_q2, pwm_d;
  reg [19:0] ctr_q, ctr_d;
  assign servo = pwm_q;
  assign servo2 = pwm_q2;
  //position (0-255) maps to 50,000 -100,000 (which corresponds to 1ms-2ms @ 50MHz)
  //this is approximately (position+165)<<8
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////    clk_wiz instantiation and wiring for generating 50 MHZ clock
  //////////////////////////////////////////////////////////////////////////////////////////////////////////
     wire clk;
      clk_wiz_0 clk_1
      (
          // Clock in ports
          .clk_in1(clk_120),
          // Clock out ports  
          .clk_out1(clk) //50 mhz clock out            
      );     
            
  wire clk_div_s;
clk_divider u0  (
			.clk_50(clk),
			.reset(rst),
			.clk_div(clk_div_s)
);
 wire[7:0]count_s; 
assign leds = position;
counter u1  (
			.clk_counter(clk_div_s),
			.reset(mode_sel),
			.count(count_s)
);
servo_mux u2  (
			.sel(mode_sel),
			.servo_control(position),
			.from_counter(count_s),
			.from_switch(switchs)
);
wire[11:0]bcd_s;
bin2bcd u6  (
			.bin(position),
			.bcd_out(bcd_s)		
);

Decoder_7SEG u3  (
			._7SEG_OUT(Seven_segment[6:0]),
			.BCD_IN(bcd_s[3:0])		
);

Decoder_7SEG u4  (
			._7SEG_OUT(Seven_segment[13:7]),
			.BCD_IN(bcd_s[7:4])		
);
Decoder_7SEG u5  (
			._7SEG_OUT(Seven_segment[20:14]),
			.BCD_IN(bcd_s[11:8])		
);


  always @(*) begin
    ctr_d = ctr_q + 1'b1;
    if (position + 9'd165 > ctr_q[19:8]) begin
      pwm_d = 1'b1;
    end else begin
      pwm_d = 1'b0;
    end
	 if (ctr_d == 1_000_000) begin
			ctr_d <= 1'b0;
	 end
  end
	
  always @(posedge clk) begin
    if (rst) begin
      ctr_q <= 1'b0;
    end else begin
      ctr_q <= ctr_d;
    end
    pwm_q <= pwm_d;
	 pwm_q2 <= pwm_d;
  end
endmodule