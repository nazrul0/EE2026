`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2023 18:48:26
// Design Name: 
// Module Name: naz_oled_control
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


module naz_oled_control(
    input clock,
    input [31:0] row,
    input [31:0] column,
    input [11:0] peak_intensity,
    output reg [15:0] oled,
    input [4:0] vol_level
    );
    
    wire clk20K;
    unit_clk my_20KHz_clk(clock,2499, clk20K);
    
    wire [15:0] show_bars;
    volume_bars (.clock(clock), .row(row), .column(column), .peak_intensity(peak_intensity), .image_data(show_bars), .vol_level(vol_level));
    
    always @ (posedge clock)
    begin
    // if on switch to show vol bars, assign oled to vol bars
        oled <= show_bars;
    
    end    
    
endmodule
