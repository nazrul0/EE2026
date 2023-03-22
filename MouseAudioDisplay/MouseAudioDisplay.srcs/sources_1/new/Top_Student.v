`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: Nazrul Syahmi Bin Murad
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input clock,
    input J_MIC3_Pin3,
    output J_MIC3_Pin1,
    output J_MIC3_Pin4,
    output reg [11:0] led,
    input [15:0] sw,
    output reg [3:0] an,
    output reg [6:0] seg
    );
    
    wire [11:0] MIC_in;
    
    Audio_Input my_audio_input(
        clock,             // 100MHz clock
        clk20K,                  // sampling clock, 20kHz
        J_MIC3_Pin3,             // J_MIC3_Pin3, serial mic input
        J_MIC3_Pin1,             // J_MIC3_Pin1
        J_MIC3_Pin4,             // J_MIC3_Pin4, MIC3 serial clock
        MIC_in                   // 12-bit audio sample data
        );
    
    reg [11:0] peak_intensity = 0;
    reg [11:0] div_intensity = 0;
    reg [11:0] count = 0;
    
    wire clk20K;
    unit_clk_20KHz my_20KHz_clk(clock, clk20K);
    
    wire [11:0] led_output;
    ld_control ld_display(clock, peak_intensity, led_output);
    
    wire [3:0] an_output; 
    wire [6:0] seg_output;
    seg_control seg_display(clock, peak_intensity, sw, an_output, seg_output);
    
    wire [15:0] oled_output;
    
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
        
        led = led_output;
        an = an_output;
        seg = seg_output;
         
    end  
endmodule