`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/17 13:56:52
// Design Name: 
// Module Name: play_note
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


module play_note(
    input clock, trigger,
    input [17:0] in_note,
    input [1:0] prg_case,
    output reg [11:0] audio_out = 0,
    output reg [15:0] led = 0
    );
    wire[7:0] n_clk;
    reg [31:0] count = 0, count_time = 124999999*3;
    reg [2:0] sound = 0;
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

 always @ (posedge clock) begin
     if (prg_case == 2) begin
     if (trigger == 1) begin
        led[15] <= 1;
        count <= (count == count_time)? 0 : count + 1;
        sound <= (count > 5*(count_time/6))? in_note[17:15] : 
             (count > 4*(count_time/6))? in_note[14:12] :
             (count > 3*(count_time/6))? in_note[11:9] :
             (count > 2*(count_time/6))? in_note[8:6] :
             (count > (count_time/6))? in_note[5:3] :
             in_note[2:0];
        case (sound)
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
        count <= 0;
     end
end
end
endmodule
