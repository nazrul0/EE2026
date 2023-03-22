`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2023 02:22:47 PM
// Design Name: 
// Module Name: tempclk
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


module tempclk(
    input CLOCK,
    output out_clk
    );
    reg temp = 0;
    assign out_clk = temp;
    integer count = 0;
    always@(posedge CLOCK) begin
        count <= count+1;
        if(count==2499)
        begin
            count <= 0;
            temp <= ~temp;
        end
    end
endmodule
