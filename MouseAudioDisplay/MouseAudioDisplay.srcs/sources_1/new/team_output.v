`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 22:43:31
// Design Name: 
// Module Name: team_output
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


module team_output (
    input clock,
    input [11:0] MIC_in,
    output reg [15:0] led,
    input [15:0] sw,
    output reg [3:0] an,
    output reg [6:0] seg,
    output reg dp,
    input [31:0] number,
    input [11:0] indiv_intensity
    );
    
    reg [11:0] peak_intensity = 0;
    reg [11:0] div_intensity = 0;
    reg [11:0] count = 0;
    
    wire clk20K;
    unit_clk my_20KHz_clk(.clock(clock), .mvalue(2499), .my_clk(clk20K));
       
    wire [15:0] led_output;
    team_ld_control team_ld_display(.clock(clock), .peak_intensity(indiv_intensity), .led(led_output), .sw(sw), .number(number));
    
    wire [3:0] an_output; 
    wire [6:0] seg_output;
    wire dp_output;
    team_seg_control team_seg_display(.clock(clock), .peak_intensity(indiv_intensity), .sw(sw), .an(an_output), .seg(seg_output), .dp(dp_output), .number(number));
        
    always @ (posedge clk20K)   // finds mic input peak intensity per 0.2s block and updates led, an, seg accordingly
    begin
        count <= count + 1;
        
        if (count == 4000)  // resets peak_intensity every 0.2 seconds
        begin
        peak_intensity <= 0;
        count <= 0;
        end
        
        if (MIC_in > peak_intensity)
        begin
        peak_intensity <= MIC_in;
        end
        
        // to verify that peak_intensity values are being fed into led and seg control properly. this means that the issue is with the peak_intensity value itself - may be assigned to MIC_in properly? 
//        if (count < 2000)
//        begin
//        peak_intensity <= 2500;
//        end        
        
//        else if (count >= 2000 && count < 3000) 
//        begin
//        peak_intensity <= 3500;
//        end
        
//        else if (count >= 3000 && count < 4000)
//        begin
//        peak_intensity <= 4000;
//        end
        
        led <= led_output;
        an <= an_output;
        seg <= seg_output;
        dp <= dp_output;

    end      
    
endmodule