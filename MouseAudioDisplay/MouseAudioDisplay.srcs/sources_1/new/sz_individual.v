`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/24 14:15:07
// Design Name: 
// Module Name: sz_individual
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


`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module sz_individual ( 
    input clk,btnC_i,btnD_i, btnU_i,btnL_i,zj_enable,
    input[15:0] sw_i,
    output[3:0] JX,
    output[15:0] led 
    );
    reg ground = 0;
    wire[15:0] sw;
    wire clk20k;
    wire clk50m;
    wire clk125;
    wire clk250;
    //reg[11:0] audio_out = 0;
    wire [11:0] audio_out;
    wire [11:0] audio_out_s, audio_out_p, audio_out_it;
    wire [15:0] led_s, led_p;
    wire sound, sound2;
    wire [17:0] music;
    wire [2:0] o_note;
    
    reg[11:0] max_a;
    reg[31:0] f_cnt;
    reg[31:0] cnt = 0; 
    wire [31:0] count_time;
    wire[1:0] prg_case;
    
    clock_divider clock_20kHz (.clock(clk),.speed_index(2499), .slow_clock(clk20k));
    clock_divider clock_50mHz (.clock(clk),.speed_index(1), .slow_clock(clk50m));
    clock_divider clock_125Hz (.clock(clk),.speed_index(399998), .slow_clock(clk125));
    clock_divider clock_250Hz (.clock(clk),.speed_index(199999), .slow_clock(clk250));
    
    num_to_count ntc (.num(10), .count_time(count_time));
    push_button_output pbo ( .prg_case(prg_case),.button(btnC_i), .clock(clk), .sw(sw[0]),.count_time(count_time), .audio_out_it(audio_out_it));
    music_box mscb ( .prg_case(prg_case),.btnU(btnU_i),.btnD(btnD_i),.btnL(btnL_i),.clock(clk),.audio_out(audio_out_p), .led(led_p), .o_note(o_note));
    //game_end_sound ges ( .victory(sw[15]),.clk(clk),.audio_out(audio_out),.trigger(btnC));
    save_note sn (.prg_case(prg_case), .trigger(sw_i[14]), .pbnC(btnC_i), .clk(clk), .note(o_note), .sw(sw_i[5:0]), .out_note(music));
    play_note pn (.prg_case(prg_case),.clock(clk),.trigger(sw[15]),.in_note(music),.audio_out(audio_out_s),.led(led_s));
    
    assign audio_out = (zj_enable == 1)? ((sw[15] == 1)? audio_out_s : 
                        (sw[13] == 1)? audio_out_it : audio_out_p)
                        :0;
    assign led =  (zj_enable == 1)?((sw[15] == 1)? led_s : led_p) : 0;
    assign prg_case = (zj_enable == 0)? 0 :
                      (sw[13] == 1)? 1:
                      (sw[15] == 1)? 2: 3;
    
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