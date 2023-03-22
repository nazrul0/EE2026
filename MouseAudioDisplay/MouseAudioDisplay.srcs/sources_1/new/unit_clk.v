`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2023 18:06:59
// Design Name: 
// Module Name: unit_clk
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


module unit_clk(input clock, input [31:0] mvalue, output reg my_clk = 0);
    
    reg [31:0] count = 0;

    always @ (posedge clock)
    begin
        count <= (count == mvalue) ? 0 : count + 1;
        my_clk <= (count == 0) ? ~my_clk : my_clk;
    end

endmodule
