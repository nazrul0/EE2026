`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2023 12:07:12 AM
// Design Name: 
// Module Name: rgb_color
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


module rgb_color(
    input [15:0] r, [15:0] g, [15:0] b,
    output [15:0] rgbHex
    );
    wire[31:0] rtemp, gtemp, btemp;
    assign btemp = (b*31)/255;
    assign gtemp = ((g*63)/255)<<5;
    assign rtemp = ((r*31)/255)<<11;
    assign rgbHex = rtemp+gtemp+btemp;
endmodule
