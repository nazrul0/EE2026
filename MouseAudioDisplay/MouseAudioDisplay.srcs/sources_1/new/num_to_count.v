`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 10:08:47
// Design Name: 
// Module Name: num_to_count
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


module num_to_count(
    input [3:0] num,
    output [31:0] count_time
    );
    reg [31:0] count = 0;
    assign count_time [31:0] = ((num == 1) ? 12499999 : (num == 2) ? 12499999*2 : 
                    (num == 3) ? 12499999*3 : (num == 4) ? 12499999*4 : 
                    (num == 5) ? 12499999*5 : (num == 6) ? 12499999*6 : 
                    (num == 7) ? 12499999*7 : (num == 8) ? 12499999*8 : 
                    (num == 9) ? 12499999*9 : (num == 10) ? 124999999 :
                    0); 
   /*                 
   always @ (posedge clk) begin
         if (count == 0) begin
                  sound <= 0;
              end
         else begin
              count <= (count == count_time)? 0 : count + 1;
              sound <= 1;
         end
   end
   */
endmodule
