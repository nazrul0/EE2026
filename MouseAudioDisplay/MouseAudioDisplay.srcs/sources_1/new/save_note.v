`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/22 14:45:01
// Design Name: 
// Module Name: save_note
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


module save_note(
    input trigger, pbnC, clk,
    input [2:0] note,
    input [5:0] sw,
    input [1:0] prg_case,
    output reg [17:0] out_note
    );
    reg[31:0] count = 0, count_b = 0;
    //124999999;
    reg isPressed = 0, isReady = 1, saving = 0;
    reg[31:0] count_time = 124999999;
    reg[31:0] debounce_c = 0, debounce_max = 249999;
    always @ (posedge clk) begin
    if (prg_case == 3) begin
    if (trigger == 1) begin  
        if ( isReady  == 1) begin
            if (pbnC == 1) begin
                isPressed <= 1;
                saving = (isPressed == 0)? 1 : saving;
                isReady <= (isPressed == 0)? 0 : isReady;
                //debounce_c <= (isPressed == 0)? 0 : debounce_c;
            end else begin
                isPressed <= 0;
                saving <= 0;
                debounce_c <= (isPressed == 1)? 0 : debounce_c;
            end
        end else begin
            if (debounce_c == debounce_max) begin
               isReady <= 1;
            end else debounce_c = debounce_c + 1;
        end
end
    if (saving == 1) begin
        out_note[2:0] <= (sw[0] == 1)? note: out_note[2:0];
        out_note[5:3] <= (sw[1] == 1)? note: out_note[5:3];
        out_note[8:6] <= (sw[2] == 1)? note: out_note[8:6];
        out_note[11:9] <= (sw[3] == 1)? note: out_note[11:9];
        out_note[14:12] <= (sw[4] == 1)? note: out_note[14:12];
        out_note[17:15] <= (sw[5] == 1)? note: out_note[17:15];
        saving <= 0;
    end  
end  
end
endmodule
