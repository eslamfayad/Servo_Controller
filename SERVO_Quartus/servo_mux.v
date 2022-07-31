`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module servo_mux(output wire [7:0] servo_control,
					 input sel,
					 input [7:0] from_counter ,from_switch );
assign servo_control = (sel == 1'b 0) ? from_counter :
                       (sel == 1'b 1) ? from_switch :
                        8'b00000000;
endmodule

















