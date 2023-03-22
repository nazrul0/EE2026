`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2023 12:16:57 AM
// Design Name: 
// Module Name: rgb_color_update
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


module rgb_color_update(
    input clock, [31:0] r, [31:0] g, [31:0] b,
    output reg [15:0] rgbHex
    );
    reg [31:0] rtemp, gtemp, btemp;
    initial begin
        btemp = (b*31)/255;
        gtemp = ((g*63)/255)<<5;
        rtemp = ((r*31)/255)<<11;
    end
    always @(posedge clock)begin
        btemp = (b*31)/255;
        gtemp = ((g*63)/255)<<5;
        rtemp = ((r*31)/255)<<11;
        rgbHex = rtemp+gtemp+btemp;
    end
endmodule
