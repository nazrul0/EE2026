`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/15 14:20:00
// Design Name: 
// Module Name: music_box
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


module music_box(
    input btnU, btnD,btnL,
    input clock,
    input [1:0] prg_case,
    output reg [11:0] audio_out = 0,
    output reg [15:0] led = 0,
    output [2:0] o_note
    );
    reg [31:0] count = 0, count_b = 0;
    reg isPressed = 0, isReady = 1, sound = 0, isTriggerU = 0, isTriggerD = 0, isTriggerL = 0, isRes = 0;
    reg[31:0] debounce_c = 0, debounce_max = 2499999, count_time = 124999999/2;
    reg [2:0] note = 0;
    wire[7:0] n_clk;
    parameter speed0 = 10000000/(392*2)-1;
    parameter speed1 = 10000000/(440*2)-1;
    parameter speed2 = 10000000/(494*2)-1;
    parameter speed3 = 10000000/(523*2)-1;
    parameter speed4 = 10000000/(587*2)-1;
    parameter speed5 = 10000000/(659*2)-1;
    parameter speed6 = 10000000/(698*2)-1;
    parameter speed7 = 10000000/(784*2)-1;
    clock_divider clock_n0 (.clock(clock),.speed_index(speed0), .slow_clock(n_clk[0]));
    clock_divider clock_n1 (.clock(clock),.speed_index(speed1), .slow_clock(n_clk[1]));
    clock_divider clock_n2 (.clock(clock),.speed_index(speed2), .slow_clock(n_clk[2]));
    clock_divider clock_n3 (.clock(clock),.speed_index(speed3), .slow_clock(n_clk[3]));
    clock_divider clock_n4 (.clock(clock),.speed_index(speed4), .slow_clock(n_clk[4]));
    clock_divider clock_n5 (.clock(clock),.speed_index(speed5), .slow_clock(n_clk[5]));
    clock_divider clock_n6 (.clock(clock),.speed_index(speed6), .slow_clock(n_clk[6]));
    clock_divider clock_n7 (.clock(clock),.speed_index(speed7), .slow_clock(n_clk[7]));
    /*
    always @ (note) begin
    speed_index = (note == 1)? 10000000/(440*2)-1:
                  (note == 2)? 10000000/(494*2)-1:
                  (note == 3)? 10000000/(523*2)-1:
                  (note == 4)? 10000000/(587*2)-1:
                  (note == 5)? 10000000/(659*2)-1:
                  (note == 6)? 10000000/(698*2)-1:
                  (note == 7)? 10000000/(784*2)-1: 10000000/(392*2)-1;
    end
    clock_divider clock_698Hz (.clock(clock),.speed_index(speed_index), .slow_clock(m_clock));
    */
    always @ (posedge clock) begin
    if (prg_case == 3) begin
        if ( isReady  == 1) begin
                if (btnU == 1 && btnD == 0 && btnL == 0)
                isTriggerU <= 1;
                else if (btnU == 0 && btnD == 1&& btnL == 0)
                isTriggerD <= 1;
                else if (btnU == 0 && btnD == 0 && btnL == 1)
                isTriggerL <= 1;
                //debounce_c <= (isPressed == 0)? 0: debounce_c;
                else begin
                isRes <= 0;
            end
        end else begin
            if (debounce_c == debounce_max) begin
               isReady <= 1;
            end else debounce_c <= debounce_c + 1;
        end
        
        if(isTriggerU == 1) begin
            isPressed <= 1;
            count <= (isPressed == 0)? 1 : count;
            note <= (isPressed == 0)? note + 1 : note;
            isReady <= (isPressed == 0)? 0 : isReady;
            isTriggerU = 0;
        end else if (isTriggerD == 1) begin
            isPressed <= 1;
            count <= (isPressed == 0)? 1 : count;
            note <= (isPressed == 0)? note - 1 : note;
            isReady <= (isPressed == 0)? 0 : isReady;
            isTriggerD = 0;
        end else if (isTriggerL == 1) begin
            isPressed <= 1;
            count <= (isPressed == 0)? 1 : count;
            isReady <= (isPressed == 0)? 0 : isReady;
            isTriggerL = 0;
        end else if (isRes == 1) begin
            isPressed <= 0;
            debounce_c <= (isPressed == 1)? 0: debounce_c;
        end
        
        if (count == 0) begin
                sound <= 0;
            end
            else begin
                count <= (count == count_time)? 0 : count + 1;
                sound <= 1;
            end
 //       end
 //always @ (posedge clock) begin
     if (sound == 1) begin
        case (note)
        0: begin audio_out[11] <= n_clk[0];led = 0; led[0] = 1;end
        1: begin audio_out[11] <= n_clk[1];led = 0; led[1] = 1;end
        2: begin audio_out[11] <= n_clk[2];led = 0; led[2] = 1;end
        3: begin audio_out[11] <= n_clk[3];led = 0; led[3] = 1;end
        4: begin audio_out[11] <= n_clk[4];led = 0; led[4] = 1;end
        5: begin audio_out[11] <= n_clk[5];led = 0; led[5] = 1;end
        6: begin audio_out[11] <= n_clk[6];led = 0; led[6] = 1;end
        7: begin audio_out[11] <= n_clk[7];led = 0; led[7] = 1;end
        //count_b <= (count_b == speed_index) ? 0: count_b + 1;
        //audio_out[11] <= (count_b == 0) ? ~audio_out[11]: audio_out[11];
        endcase
     end else begin
        audio_out[11] <= 0;
        led <= 0;
     end
 end
 end
assign o_note = note;              
    
endmodule
