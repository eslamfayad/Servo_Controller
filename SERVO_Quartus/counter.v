module counter ( output reg[7:0] count ,
						input wire clk_counter,reset);
	reg flag =0;					
always @ (posedge clk_counter or posedge reset)
	begin: COUNTER 
		if (reset) begin
			count <=0;
		end
		else
		  if (flag == 1)begin
		    
						if(count > 0) begin
							count <= count-1'd1;
			         
						end
					else
						flag = 0;
			end
		  else if (flag ==0)begin
						
						if (count < 255) begin
						   count <= count+1'd1;
							
						end
						else
						   flag <= 1;
				
			end
				
		end
		

		
endmodule 