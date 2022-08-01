module clk_divider ( output wire clk_div ,
						input wire clk_50,reset);
reg clk;
reg[20:0] count;						
always @ (posedge clk_50 or negedge reset)
	begin: divider 
		if (reset) begin
			count <=0;
			clk <= 0 ;
		end
		else if (count == 1_250_000) begin
			 count <= 0;
			 clk <= ~clk ;
		end
		else
			 count <= count+1'd1;
	end
		
assign clk_div = clk;
endmodule 