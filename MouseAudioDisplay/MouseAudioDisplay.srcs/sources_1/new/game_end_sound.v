`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 11:12:24
// Design Name: 
// Module Name: game_end_sound
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


module game_end_sound(
    input victory,
    input clk,
    output [3:0] JX,
    input trigger
    );
    reg[31:0] count = 0, count_b = 0;
    reg [11:0] audio_out = 0;
    //124999999;
    reg isPressed = 0, isReady = 1;
    reg [1:0] sound = 0;
    reg[31:0] count_time = 124999999;
    reg[31:0] debounce_c = 0, debounce_max = 2499999,  speed1 = 10000000/(440*2)-1, speed2 = 10000000/(698*2)-1;
    wire clk440, clk698;
    wire clk20k;
    wire clk50m;
    clock_divider clock_440Hz (.clock(clk),.speed_index(speed1), .slow_clock(clk440));
    clock_divider clock_698Hz (.clock(clk),.speed_index(speed2), .slow_clock(clk698));
    clock_divider clock_20kHz (.clock(clk),.speed_index(2499), .slow_clock(clk20k));
    clock_divider clock_50mHz (.clock(clk),.speed_index(1), .slow_clock(clk50m));
    
    always @ (posedge clk) begin
            if (trigger == 1) begin
                isPressed <= 1;
                count = (isPressed == 0)? 1 : count;
                isReady <= (isPressed == 0)? 0 : isReady;
                debounce_c <= (isPressed == 0)? 0: debounce_c;
            end else begin
                isPressed = 0;
            end
        //if (isPressed) begin
            if (count == 0) begin
                sound <= 0;
            end
            else begin
                count <= (count == count_time)? 0 : count + 1;
                sound <= (count > count_time/2)? 2: 1;
            end
        end
        
        always @ (posedge clk) begin
             if (sound == 1) begin
                audio_out[11] <= (victory==1)? clk440 : clk698;
             end else if (sound == 2) begin
                audio_out[11] <= (victory==1)? clk698 : clk440;
             end else 
                audio_out[11] = 0;
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
