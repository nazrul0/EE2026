`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/29 16:01:25
// Design Name: 
// Module Name: play_team_sound
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


module play_team_sound( input button, clock, input [3:0] num,
output [3:0] JX, output reg done = 0 );
    reg[31:0] count = 0;
    //124999999;
    reg isPressed = 0, isReady = 1;
    //reg[31:0] count_1s = 124999999;
    reg[31:0] debounce_c = 0, debounce_max = 2499999;
    reg sound = 0, isPlaying = 0;
    wire clk125;
    wire clk250;
    wire clk20k;
    wire clk50m;
    reg[11:0] audio_out = 0;
    reg [31:0] count_time = 0;

    clock_divider clock_125Hz (.clock(clock),.speed_index(399998), .slow_clock(clk125));
    clock_divider clock_250Hz (.clock(clock),.speed_index(199999), .slow_clock(clk250));
    clock_divider clock_20kHz (.clock(clock),.speed_index(2499), .slow_clock(clk20k));
    clock_divider clock_50mHz (.clock(clock),.speed_index(1), .slow_clock(clk50m));
    
 
    always @ (posedge clock) begin
            count_time [31:0] = ((num == 1) ? 12499999 : (num == 2) ? 12499999*2 : 
                            (num == 3) ? 12499999*3 : (num == 4) ? 12499999*4 : 
                            (num == 5) ? 12499999*5 : (num == 6) ? 12499999*6 : 
                            (num == 7) ? 12499999*7 : (num == 8) ? 12499999*8 : 
                            (num == 9) ? 12499999*9 : (num == 10) ? 124999999 :
                            0);
            if (button == 1) begin
                isPressed <= 1;
                count = (isPressed == 0)? 1 : count;
            end else begin
                isPressed = 0;
            end
            if (count == 0) begin
                sound <= 0;
                done <= (isPlaying == 1)? 1 : 0;
                isPlaying <= 0;
            end
            else begin
                count <= (count == count_time)? 0 : count + 1;
                sound <= 1;
                isPlaying <= 1;
            end
        end
            always @ (posedge clock) begin
            if (sound == 1) begin
                audio_out[11] <= clk250;
            end
           else 
                audio_out <= 0;
        end 
        
      Audio_output test_out(
        .CLK(clk50m),      //-- System Clock (50MHz)     
        .START(clk20k),    //-- Sampling clock 20kHz
        .DATA1(audio_out),  // -- 12-bit digital data1
        .DATA2(),   // -- 12-bit digital data2
        .RST(0),      //--1'
        //outputs
        .D1(JX[1]),   // -- PmodDA2 Pin2 (Serial data1)
        .D2(JX[2]),   // -- PmodDA2 Pin3 (Serial data2)
        .CLK_OUT(JX[3]),  // -- PmodDA2 Pin4 (Serial Clock)
        .nSYNC(JX[0]),   // -- PmodDA2 Pin1 (Chip Select)
        .DONE()
        ); 
         
endmodule
