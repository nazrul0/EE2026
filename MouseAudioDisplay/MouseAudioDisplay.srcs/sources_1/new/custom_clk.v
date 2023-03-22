`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2023 01:38:07
// Design Name: 
// Module Name: custom_clk
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


module custom_clk(input clock, input [31:0] m_value, output reg my_clk = 0);
    
    reg [31:0] count = 0;

    always @ (posedge clock)
    begin
        count <= (count == m_value) ? 0 : count + 1;
        my_clk <= (count == 0) ? ~my_clk : my_clk;
    end

endmodule