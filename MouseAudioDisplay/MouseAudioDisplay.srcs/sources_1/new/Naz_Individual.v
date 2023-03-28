`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2023 17:51:48
// Design Name: 
// Module Name: Naz_Individual
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


module Naz_Individual (
    input clock,
    input enable,
    input [11:0] MIC_in,
    output reg [15:0] led,
    input [15:0] sw,
    output reg [3:0] an,
    output reg [6:0] seg,
    input [10:0] row,
    input [10:0] column,
    output reg [15:0] oled
    );
    
    reg [11:0] peak_intensity = 0;
    reg [11:0] div_intensity = 0;
    reg [11:0] count = 0;
    
    wire clk20K;
    unit_clk my_20KHz_clk(.clock(clock), .mvalue(2499), .my_clk(clk20K));
    
    wire [11:0] led_output;
    naz_ld_control naz_ld_display(.clock(clock), .peak_intensity(peak_intensity), .led(led_output), .frequency(frequency), .sw(sw));   // to add frequency as input before sw
    
    wire [3:0] an_output; 
    wire [6:0] seg_output;
    naz_seg_control naz_seg_display(.clock(clock), .peak_intensity(peak_intensity), .sw(sw), .an(an_output), .seg(seg_output));
    
    wire [15:0] oled_output;
    naz_oled_control naz_oled_display(.clock(clock), .peak_intensity(peak_intensity), .oled(oled_output));
    
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
        
        led <= led_output;
        an <= an_output;
        seg <= seg_output;
        oled <= oled_output;

    end  
    
    reg [31:0] sample_counter = 0;       // count how many times value appears
    reg start_clock_counter = 0;        
    reg [31:0] clock_counter = 0;       // records time taken for value_counter to reach 1000
    reg [31:0] frequency = 0;
    
    always @ (posedge clock)
    begin
        if (MIC_in == 2507 && clock_counter == 0)
        begin
            start_clock_counter <= 1;
        end
        
        if (start_clock_counter == 1)
        begin
            clock_counter <= clock_counter + 1;
        end
        
        if (MIC_in == 2507 && sample_counter < 1000)
        begin
            sample_counter <= sample_counter + 1;
        end
        
        if (sample_counter == 1000)
        begin
            frequency <= (500 * 100000000) / clock_counter;
            
            sample_counter <= 0;
            start_clock_counter <= 0;
            clock_counter <= 0;
        end
        
//        if (MIC_in == 2507)
//        begin
//            sample_counter <= sample_counter + 1;
//        end
        
//        if (sample_counter >= 1 && sample_counter <1000)
//        begin
//            clock_counter <= clock_counter + 1;
//        end
        
//        else if (sample_counter == 1000)
//        begin
//            frequency <= (500 * 100000000) / clock_counter;
////            frequency <= (sample_counter * 100000000)/(2 * clock_counter);
            
//            sample_counter <= 0;
//            clock_counter <= 0;
//        end
    end
    
endmodule
