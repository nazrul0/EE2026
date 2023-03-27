`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/01 15:11:21
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(input clock, input[31:0] speed_index, output reg slow_clock = 0);
  
   reg [31:0] count = 0;
  
   always @ (posedge clock) begin
        count <= (count == speed_index) ? 0: count + 1;
        slow_clock <= (count == 0) ? ~slow_clock: slow_clock;
   end

endmodule
