module Decoder_7SEG (
output reg[6:0] _7SEG_OUT,
input wire [3:0] BCD_IN);

//reg[6:0] _7SEG_OUT;

always @(*)
begin
	case(BCD_IN)
		4'b0000: _7SEG_OUT = 7'b1000000; // "0"  
		4'b0001: _7SEG_OUT = 7'b1111001; // "1" 
		4'b0010: _7SEG_OUT = 7'b0100100; // "2" 
		4'b0011: _7SEG_OUT = 7'b0110000; // "3" 
		4'b0100: _7SEG_OUT = 7'b0011001; // "4" 
		4'b0101: _7SEG_OUT = 7'b0010010; // "5" 
		4'b0110: _7SEG_OUT = 7'b0000010; // "6" 
		4'b0111: _7SEG_OUT = 7'b1111000; // "7" 
		4'b1000: _7SEG_OUT = 7'b0000000; // "8"  
		4'b1001: _7SEG_OUT = 7'b0010000; // "9" 
	default: _7SEG_OUT = 7'b1000000; // "0"
	endcase
 end
 endmodule 