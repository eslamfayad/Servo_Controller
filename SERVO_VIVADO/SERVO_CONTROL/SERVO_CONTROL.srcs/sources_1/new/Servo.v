`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2022 11:37:25 PM
// Design Name: 
// Module Name: Servo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// 1msec       50_000 count 
// 1.5msec     750_000
// 2msec       100_000
// 20msec      1_000_000

module Servo(
input clk,
input button_R,
input button_L,
//output [0:0] LED,
output servo );


reg [21:0] count =0;
reg        servo_Reg;
reg [17:0] control = 0 ;

always @(posedge clk)
begin
   
   if (count == 'd2_500_000)
        count <= 0;
        else 
       count <= count+ 1;
   
   if (count < ('d125_000 + control))
        servo_Reg <= 1;
   else 
         servo_Reg <= 0;
   
    
      //end
      
 end 
 always @ *
 begin
    if(control < 'd125000)
       if (button_R == 1)
           control = control+ 'd694;
        else 
           ;
    else
        ; 
        
     //  if(control > 'd278)
          //   if (button_R == 1)
            //    control = control - 'd278;
            //  else 
             //       ;
            // else
               //  control <= 0;
 end
 
 assign servo	= servo_Reg;
 endmodule