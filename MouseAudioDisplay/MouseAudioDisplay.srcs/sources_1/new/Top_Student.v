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
    // Delete this comment and include Basys3 inputs and outputs here
    input clock, btnU, btnL, btnR, btnD, btnC, [15:0]sw,
    input JB3, // JB3 is J_MIC3_Pin3,   
    inout PS2Clk, PS2Data,
    output reg dp, [7:0] JC, reg [15:0] led, reg [3:0] an, reg [6:0] seg, reg JB1, reg JB4, // JB1, JB4 are J_MIC3_Pin1, J_MIC3_Pin4
    output reg [3:0] JA
    );
    reg [11:0] mouseValue=0;
    wire [11:0] xpos,ypos;
    wire [3:0] zpos;
    wire left, right, middle, new_event;
    reg clk6p25m = 0;
    integer clk6p25m_count = 0;
    reg[15:0] oled_data = 16'h07E0;
    wire frame_begin, sending_pixels, sample_pixel;
    wire[12:0] pixel_index;
    integer row, column;
    integer s [12:0][3:0];
    reg [12:0] seg_active = 13'b0000000000000;
    reg [12:0] is_valid [9:0];
    reg brk = 1'b0;
    integer number=10;
    integer grid[5:0][2:0][3:0];
    reg [1:0] state[5:0][2:0];
    reg [1:0] win_state = 0;
    integer win_row = 3;
    integer win_col = 1;
    integer win_count = 0;
    integer num_lives;
    wire [15:0] gameover;
    wire [15:0] win;
    wire [15:0] menu;
    reg [4:0] menuState = 0;
    reg [4:0] menuSelect = 0;
    integer pressedR = 0;
    integer pressedL = 0;
    reg arty_enable;
    wire arty_dp;
    wire [15:0] arty_led;
    wire [3:0] arty_an;
    wire [6:0] arty_seg;
    wire [15:0] arty_oled;
    reg [6:0] mousex, mousey;
   
    //Szj's declarations
    reg zj_enable = 0;
    wire [3:0] zj_JA;
    wire [15:0] zj_led;
    reg victory_sound = 0, trigger_ges = 0;
    wire [3:0] team_imp_JA;
    
    initial begin
        s[0][0]=5;s[0][1]=13;s[0][2]=5;s[0][3]=13;
        s[1][0]=5;s[1][1]=13;s[1][2]=13;s[1][3]=37;
        s[2][0]=5;s[2][1]=13;s[2][2]=37;s[2][3]=45;
        s[3][0]=13;s[3][1]=25;s[3][2]=5;s[3][3]=13;
        s[4][0]=13;s[4][1]=25;s[4][2]=37;s[4][3]=45;
        s[5][0]=25;s[5][1]=33;s[5][2]=5;s[5][3]=13;
        s[6][0]=25;s[6][1]=33;s[6][2]=13;s[6][3]=37;
        s[7][0]=25;s[7][1]=33;s[7][2]=37;s[7][3]=45;
        s[8][0]=33;s[8][1]=45;s[8][2]=5;s[8][3]=13;
        s[9][0]=33;s[9][1]=45;s[9][2]=37;s[9][3]=45;
        s[10][0]=45;s[10][1]=53;s[10][2]=5;s[10][3]=13;
        s[11][0]=45;s[11][1]=53;s[11][2]=13;s[11][3]=37;
        s[12][0]=45;s[12][1]=53;s[12][2]=37;s[12][3]=45;
        is_valid[0]=13'b1111110111111;
        is_valid[1]=13'b1001010010100;
        is_valid[2]=13'b1110111110111;
        is_valid[3]=13'b1111011110111;
        is_valid[4]=13'b1001011111101;
        is_valid[5]=13'b1111011101111;
        is_valid[6]=13'b1111111101111;
        is_valid[7]=13'b1001010010111;
        is_valid[8]=13'b1111111111111;
        is_valid[9]=13'b1111011111111;
        led = 16'b0000000000000000;
        grid[0][0][0]=2;grid[0][0][1]=12;grid[0][0][2]=63;grid[0][0][3]=73;
        grid[0][1][0]=2;grid[0][1][1]=12;grid[0][1][2]=73;grid[0][1][3]=83;
        grid[0][2][0]=2;grid[0][2][1]=12;grid[0][2][2]=83;grid[0][2][3]=93;
        grid[1][0][0]=12;grid[1][0][1]=22;grid[1][0][2]=63;grid[1][0][3]=73;
        grid[1][1][0]=12;grid[1][1][1]=22;grid[1][1][2]=73;grid[1][1][3]=83;
        grid[1][2][0]=12;grid[1][2][1]=22;grid[1][2][2]=83;grid[1][2][3]=93;
        grid[2][0][0]=22;grid[2][0][1]=32;grid[2][0][2]=63;grid[2][0][3]=73;
        grid[2][1][0]=22;grid[2][1][1]=32;grid[2][1][2]=73;grid[2][1][3]=83;
        grid[2][2][0]=22;grid[2][2][1]=32;grid[2][2][2]=83;grid[2][2][3]=93;
        grid[3][0][0]=32;grid[3][0][1]=42;grid[3][0][2]=63;grid[3][0][3]=73;
        grid[3][1][0]=32;grid[3][1][1]=42;grid[3][1][2]=73;grid[3][1][3]=83;
        grid[3][2][0]=32;grid[3][2][1]=42;grid[3][2][2]=83;grid[3][2][3]=93;
        grid[4][0][0]=42;grid[4][0][1]=52;grid[4][0][2]=63;grid[4][0][3]=73;
        grid[4][1][0]=42;grid[4][1][1]=52;grid[4][1][2]=73;grid[4][1][3]=83;
        grid[4][2][0]=42;grid[4][2][1]=52;grid[4][2][2]=83;grid[4][2][3]=93;
        grid[5][0][0]=52;grid[5][0][1]=62;grid[5][0][2]=63;grid[5][0][3]=73;
        grid[5][1][0]=52;grid[5][1][1]=62;grid[5][1][2]=73;grid[5][1][3]=83;
        grid[5][2][0]=52;grid[5][2][1]=62;grid[5][2][2]=83;grid[5][2][3]=93;
        state[0][0]=0;
        state[0][1]=0;
        state[0][2]=0;
        state[1][0]=0;
        state[1][1]=0;
        state[1][2]=0;
        state[2][0]=0;
        state[2][1]=0;
        state[2][2]=0;
        state[3][0]=0;
        state[3][1]=0;
        state[3][2]=0;
        state[4][0]=0;
        state[4][1]=0;
        state[4][2]=0;
        state[5][0]=0;
        state[5][1]=0;
        state[5][2]=0;
        seg_active = is_valid[5];
        num_lives = 5;
    end 
    always@(posedge clock)begin
        clk6p25m_count <= clk6p25m_count + 1;
        if (clk6p25m_count == 7)begin
            clk6p25m_count <= 0;
            clk6p25m <= ~clk6p25m;
        end
        row = pixel_index/96;
        column = pixel_index%96;
        if(row>63)begin
            row=63;
        end
        if(column>95)begin
            column=95;
        end
        
        oled_data <= 16'h0000;
        if(sw[0]==1)menuState<=0;
        if(menuState!=1)arty_enable=0;
        if(menuState!=2)zj_enable = 0;
        if(menuState!=3)naz_enable=0;
        if(menuState==0)begin
            an = 4'b1111;
            dp = 1;
            seg = 7'b1111111;
            led = 0;
            if(menuSelect<4&&btnR&&pressedR==0)begin
                menuSelect<=menuSelect+1;
                pressedR=1;
            end else if(menuSelect==4&&btnR&&pressedR==0)begin
                menuSelect<=0;
                pressedR=1;
            end
            if(menuSelect>0&&btnL&&pressedL==0)begin
                menuSelect<=menuSelect-1;
                pressedL=1;
            end else if (menuSelect==0&&btnL&&pressedL==0)begin
                menuSelect<=4;
                pressedL=1;
            end
            if(btnR)begin
                pressedR=1;
            end
            if(btnL)begin
                pressedL=1;
            end
            if(btnR==0&&pressedR>0)begin
                pressedR<=pressedR+1;
                if(pressedR==2499999)pressedR<=0;
            end
            if(btnL==0&&pressedL>0)begin
                pressedL<=pressedL+1;
                if(pressedL==2499999)pressedL<=0;
            end
            if(btnC==1)begin
                menuState<=menuSelect+1;
            end
            if(menuSelect<0)menuSelect=0;
            if(menuSelect>4)menuSelect=4;
            oled_data <= menu;
            if(menuSelect==0&&row>=24&&row<=40&&column>=8&&column<=24)begin
                oled_data <= 16'hFFFF-menu;
            end
            if(menuSelect==1&&row>=24&&row<=40&&column>=24&&column<=40)begin
                oled_data <= 16'hFFFF-menu;
            end
            if(menuSelect==2&&row>=24&&row<=40&&column>=40&&column<=56)begin
                oled_data <= 16'hFFFF-menu;
            end
            if(menuSelect==3&&row>=24&&row<=40&&column>=56&&column<=72)begin
                oled_data <= 16'hFFFF-menu;
            end
            if(menuSelect==4&&row>=24&&row<=40&&column>=72&&column<=88)begin
                oled_data <= 16'hFFFF-menu;
            end
        end else if(menuState==1)begin
        /*
        ** Artemis Individual Code Section Begin
        */
            arty_enable = 1;
            oled_data <= arty_oled;
            seg <= arty_seg;
            an <= arty_an;
            dp <= arty_dp;
            led <= arty_led;
        /*
        ** Artemis Individual Code Section End
        */
        end else if(menuState==2)begin
        //SZ
        zj_enable = 1;
        JA <= zj_JA;
        led <= zj_led;
        
        end else if(menuState==3)begin
        //NS
            naz_enable <= 1;
            oled_data <= naz_oled;
            seg <= naz_seg;
            an <= naz_an;
            led <= naz_led;
            JB1 <= jb1;
            JB4 <= jb4;
        end else if(menuState==4)begin
        //IRP
        end else begin
        //TEAM
        JA <= team_imp_JA;
        trigger_ges <= 0;
            if(sw[14]==1)begin
                win_state = 2;
            end
            if(btnC==1)begin
                seg_active = is_valid[5];
                win_count = 0;
                win_state = 0;
                win_row = (win_row+4)%6;
                win_col = (win_col+2)%3;
                num_lives = 5;
                for(integer i = 0;i<6;i=i+1)begin
                    for(integer j = 0;j<3;j=j+1)begin
                        state[i][j]=0;
                    end
                end
            end
            if(win_state==0)begin
                mousex <= (xpos/10 >= 96) ? 95: xpos/10;
                mousey <= (ypos/10 >= 64) ? 63: ypos/10;
                for(integer i=0;i<16;i=i+1)led[i]<=0;
                if(state[win_row][win_col]==2)begin
                    win_count<=win_count+1;
                    if(win_count==49999999)begin
                        win_state=2;
                    end
                end else begin
                    win_count=0;
                end
                if(sw[11]==1)begin
                    if(row<=61&&column>57&&column<=60)begin
                        oled_data <= 16'h07E0;
                    end
                    if(row>58&&row<=61&&column<=60)begin
                        oled_data <= 16'h07E0;
                    end
                end
                if(column>=5&&column<=45)begin
                    if(row==5||row==13||row==25||row==33||row==45||row==53)begin
                        oled_data <= 16'hFFFF;
                    end
                end
                if(row>=5&&row<=53)begin
                    if(column==5||column==13||column==37||column==45)begin
                        oled_data<=16'hFFFF;
                    end
                end
                if(column >= 63 && column <=93)begin
                    if(row==2 || row==12 || row==22 || row==32 || row==42 || row==52 || row==62)begin
                        oled_data<=16'hFFFF;
                    end
                end
                if(row>=2&&row<=62)begin
                    if(column==63||column==73||column==83||column==93)begin
                        oled_data<=16'hFFFF;
                    end
                end
                
                number = 10;
                for(integer i = 0;i<10;i=i+1)begin
                    if(seg_active==is_valid[i])begin
                        number = i;
                    end
                end
                
//                    if (sw[15] == 1)
//                    begin
//                        led[15] <= 1;
//                    end
                    
                    seg <= team_seg;
                    an <= team_an;
                    dp <= team_dp;
                    led <= team_led;

//                naz_enable <= 1;
//                seg <= naz_seg;
//                an <= naz_an;
//                dp <= naz_dp;
//                led <= naz_led;
                
                if (number<10)begin
                    num_lives = number;
                end
                brk=0;
                for(integer i = 1;i<10;i=i+1)begin
                    if(sw[i]==1&&brk==0)begin
                        seg_active=is_valid[i];
                        brk=1;
                    end
                end
                for(integer i = 0;i<13;i=i+1)begin
                    if(seg_active[i]==1&&row>s[i][0]&&row<s[i][1]&&column>s[i][2]&&column<s[i][3])begin
                        oled_data<=16'hFFFF;
                    end
                    if(mousey>s[i][0]&&mousey<s[i][1]&&mousex>s[i][2]&&mousex<s[i][3]&&left)begin
                        seg_active[i]<=1;
                    end
                    if(mousey>s[i][0]&&mousey<s[i][1]&&mousex>s[i][2]&&mousex<s[i][3]&&right)begin
                        seg_active[i]<=0;
                    end
                end
                
                for(integer i = 0;i<6;i=i+1)begin
                    for(integer j = 0;j<3;j=j+1)begin
                        if(row>grid[i][j][0]&&row<grid[i][j][1]&&column>grid[i][j][2]&&column<grid[i][j][3])begin
                            if(state[i][j]==0)begin
                                oled_data<=16'h07FF;
                            end
                            if(state[i][j]==1)begin
                                oled_data<=16'hFCE0;
                            end
                            if(state[i][j]==2)begin
                                oled_data<=16'hF800;
                            end
                        end
                        if(mousey>grid[i][j][0]&&mousey<grid[i][j][1]&&mousex>grid[i][j][2]&&mousex<grid[i][j][3]&&left&&state[i][j]==0)begin
                            if(i==win_row&&j==win_col)begin
                                state[i][j]<=2;
                                win_state<=2;
                            end else begin
                                state[i][j]<=1;
                                seg_active<=is_valid[num_lives-1];
                            end
                        end
                    end
                end
                if(column==mousex && row==mousey) oled_data<=16'hF81F;
                if(num_lives==0)win_state = 1;
            end else if (win_state == 1)begin
                oled_data <= gameover;
                victory_sound <= 0;
                trigger_ges <= 1;
            end else begin
                oled_data <= win;
                victory_sound <= 1;
                trigger_ges <= 1;
            end
        end
    end
    
    

    Oled_Display oled(
    .clk(clk6p25m), .reset(), 
    .frame_begin(frame_begin), .sending_pixels(sending_pixels), .sample_pixel(sample_pixel), .pixel_index(pixel_index),
    .pixel_data(oled_data), .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]),.pmoden(JC[7]));  
    Menu_Data menuImage(.row(row),.column(column),.image_data(menu));
    Game_Over_Image (.row(row),.column(column),.image_data(gameover));
    Win_Data winImage(.row(row),.column(column),.image_data(win));
    Artemis_Individual arty(.clock(clock), .btnU(btnU), .btnL(btnL), .btnR(btnR), .btnD(btnD), .btnC(btnC), .enable(arty_enable), .sw(sw), .y(row), .x(column), .dp(arty_dp), .led(arty_led), .an(arty_an), .seg(arty_seg), .oled(arty_oled));
    
    wire clk20K;
    unit_clk my_20KHz_clk(.clock(clock), .mvalue(2499), .my_clk(clk20K));
    
    reg [2:0] naz_enable;
    wire [11:0] naz_led;
    wire [3:0] naz_an;
    wire [6:0] naz_seg;
    wire [15:0] naz_oled;
    wire naz_dp;
    wire jb1, jb4;

    wire [11:0] MIC_in;
    Audio_Input my_audio_input(
        clock,                   // 100MHz clock
        clk20K,                  // sampling clock, 20kHz
        JB3,                     // J_MIC3_Pin3, serial mic input
        jb1,                     // J_MIC3_Pin1
        jb4,                     // J_MIC3_Pin4, MIC3 serial clock
        MIC_in                   // 12-bit audio sample data
        );
    
    
    wire [15:0] team_led;
    wire [3:0] team_an;
    wire [6:0] team_seg;
    wire team_dp;
    team_output team(.clock(clock), .MIC_in(MIC_in), .led(team_led), .sw(sw), .an(team_an), .seg(team_seg), .dp(team_dp), .number(number));  // change number here back to variable once 4e2 is ready
    MouseCtl (.clk(clock), .ps2_clk(PS2Clk), .ps2_data(PS2Data), .value(mouseValue), .setx(0), .sety(0),.setmax_x(0),.setmax_y(0),.xpos(xpos),.ypos(ypos),.zpos(zpos),.left(left),.right(right),.middle(middle),.new_event(new_event),.rst(0));
    
    Naz_Individual naz(
        .clock(clock),
        .enable(naz_enable),
        .MIC_in(MIC_in),
        .led(naz_led),
        .sw(sw),
        .an(naz_an),
        .seg(naz_seg),
        .row(row), 
        .column(column),
        .oled(naz_oled),
        .dp(naz_dp),
        .number(number)
        );
        

        sz_individual szj ( 
            .clk(clock),
            .btnC_i(btnC),
            .btnD_i(btnD), 
            .btnU_i(btnU),
            .btnL_i(btnL),
            .zj_enable(zj_enable),
            .sw_i(sw),
            .JX(zj_JA),
            .led(zj_led) 
            );

  game_end_sound gesound(
                .victory(victory_sound),
                .clk(clock),
                .JX(team_imp_JA),
                .trigger(trigger_ges)
                );
    
endmodule