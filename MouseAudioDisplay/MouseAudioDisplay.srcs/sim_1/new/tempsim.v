`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2023 02:32:17 PM
// Design Name: 
// Module Name: tempsim
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


module tempsim(
    );
    reg CLOCK;
    wire out_clk;
    tempclk dut(CLOCK,out_clk);
    initial begin
        CLOCK = 0;
    end
    always begin
        #5 CLOCK = ~CLOCK;
    end
endmodule
