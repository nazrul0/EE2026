`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/01 16:23:11
// Design Name: 
// Module Name: push_button_output
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

module push_button_output( input button, clock, sw, input [31:0] count_time, input [1:0] prg_case, 
output reg [11:0] audio_out_it = 0 );
    reg[31:0] count = 0;
    //124999999;
    reg isPressed = 0, isReady = 1;
    //reg[31:0] count_1s = 124999999;
    reg[31:0] debounce_c = 0, debounce_max = 2499999;
    reg sound = 0;
    wire clk125;
    wire clk250;

    clock_divider clock_125Hz (.clock(clock),.speed_index(399998), .slow_clock(clk125));
    clock_divider clock_250Hz (.clock(clock),.speed_index(199999), .slow_clock(clk250));
    
    always @ (posedge clock) begin
    if (prg_case == 1) begin
        if ( isReady  == 1) begin
            if (button == 1) begin
                isPressed <= 1;
                count = (isPressed == 0)? 1 : count;
                isReady <= (isPressed == 0)? 0 : isReady;
            end else begin
                isPressed = 0;
                debounce_c = 0;
            end
        end else begin
            if (debounce_c == debounce_max) begin
               isReady <= 1;
            end else debounce_c = debounce_c + 1;
        end
            if (count == 0) begin
                sound <= 0;
            end
            else begin
                count <= (count == count_time)? 0 : count + 1;
                sound <= 1;
            end
        end
 end
            always @ (posedge clock) begin
            if (sound == 1) begin
                audio_out_it[0] <= (sw == 0)? 0 : clk125;
                audio_out_it[1] <= (sw == 0)? 0 : clk125;
                audio_out_it[2] <= (sw == 0)? 0 : clk125;
                audio_out_it[3] <= (sw == 0)? 0 : clk125;
                audio_out_it[4] <= (sw == 0)? 0 : clk125;
                audio_out_it[5] <= (sw == 0)? 0 : clk125;
                audio_out_it[6] <= (sw == 0)? 0 : clk125;
                audio_out_it[7] <= (sw == 0)? 0 : clk125;
                audio_out_it[8] <= (sw == 0)? 0 : clk125;
                audio_out_it[9] <= (sw == 0)? 0 : clk125;
                audio_out_it[10] <= (sw == 0)? 0 : clk125;
                audio_out_it[11] <= (sw == 0)? clk250 : clk125;
            end
           else 
                audio_out_it <= 0;
        end   
endmodule
