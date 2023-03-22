`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2023 14:23:28
// Design Name: 
// Module Name: unit_clk_20KHz
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


module unit_clk_20KHz(input clock, output reg my_clk = 0);
    
    reg [31:0] count = 0;

    always @ (posedge clock)
    begin
        count <= (count == 2499) ? 0 : count + 1;
        my_clk <= (count == 0) ? ~my_clk : my_clk;
    end

endmodule