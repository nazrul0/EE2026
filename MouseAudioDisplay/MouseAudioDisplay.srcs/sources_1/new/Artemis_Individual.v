`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2023 11:46:47 PM
// Design Name: 
// Module Name: Artemis_Individual
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


module Artemis_Individual(
    input clock, btnU, btnL, btnR, btnD, btnC, enable,[15:0]sw,[10:0]y, [10:0]x,
    output reg dp, reg [15:0] led, reg [3:0] an, reg [6:0] seg, reg[15:0] oled
    );
    wire [15:0]skyColor;
    reg [2:0] spriteState = 0;
    wire [15:0] sprite;
    reg[9:0] spriteX=50,spriteY=47;
    reg[7:0] spriteOffsetX=0,spriteOffsetY=0;
    reg[22:0] moveLeftCount=0,moveRightCount=0;
    reg[22:0] doneMove=2499999;
    reg [6:0] segCode[9:0];
    reg[20:0] charge=500;
    reg[20:0] seg0,seg1,seg2,seg3;
    reg[20:0] chargeTimer=0;
    reg[20:0] chargeSegmentDone=499999;
    reg[4:0] chargeCount=0;
    reg[19:0] chargeCountTimer=0;
    reg[19:0] chargeCountTimerDone=99999;
    reg[22:0] railR;
    reg[22:0] railG;
    reg[22:0] railB;
    reg railFired = 0;
    reg[10:0] railL,railRR;
    reg[26:0] railCounter=0;
    reg[26:0] railDuration=29999999;
    reg[26:0] railCounterSmall, railDurationSmall;
    reg[26:0] railFR, railFG, railFB;
    wire [15:0] railFColor;
    wire [15:0] railColor;
    reg[26:0] ballTimer = 99999999;
    reg[26:0] ballRespawnTimer = 0;
    reg ballExists = 0;
    integer ballX=50,ballY=0;
    reg[11:0] timeBetweenShots=0;
    reg[26:0] ballSpeed = 15625000;
    reg[26:0] ballSpeedCounter = 0;
    integer intX,intY;
    reg lost = 0;
    wire [15:0] gameover;
    initial begin
        led<=16'h0000;
        an<=4'b1111;
        dp<=1;
        seg<=7'b1111111;
        oled<=16'h0000;
        segCode[0]=7'b1000000;
        segCode[1]=7'b1111001;
        segCode[2]=7'b0100100;
        segCode[3]=7'b0110000;
        segCode[4]=7'b0011001;
        segCode[5]=7'b0010010;
        segCode[6]=7'b0000010;
        segCode[7]=7'b1111000;
        segCode[8]=7'b0000000;
        segCode[9]=7'b0010000;
    end
    always@(posedge clock)begin
        if(enable)begin
            if(btnC&&lost)begin
                ballExists=0;
                charge=500;
                lost=0;
                spriteX=50;
                chargeCount=0;
                chargeCountTimer=0;
                railCounter=0;
                ballSpeedCounter=0;
                ballRespawnTimer=0;
            end
            if(!lost)begin
                intX=x;
                intY=y;
                oled<=skyColor;
                railCounterSmall=railCounter/1000;
                railDurationSmall=railDuration/1000;
                if(chargeCount==4)chargeCount=0;
                if(charge>1000)charge=1000;
                chargeCountTimer<=chargeCountTimer+1;
                if(chargeCountTimer==chargeCountTimerDone)begin
                    chargeCountTimer<=0;
                    chargeCount<=chargeCount+1;
                    if(chargeCount==3)chargeCount<=0;
                end
                chargeTimer<=chargeTimer+1;
                if(chargeTimer==chargeSegmentDone)begin
                    chargeTimer<=0;
                    if(charge<1000)charge<=charge+1;
                end
                if(chargeCount==0||chargeCount==4)begin
                    seg0=charge/1000;
                    seg<=segCode[seg0];
                    dp<=1;
                    an<=4'b0111;
                end else if(chargeCount==1)begin
                    seg1=(charge/100)%10;
                    seg<=segCode[seg1];
                    dp<=1;
                    an<=4'b1011;
                end else if(chargeCount==2)begin
                    seg2=(charge/10)%10;
                    seg<=segCode[seg2];
                    dp<=0;
                    an<=4'b1101;
                end else if(chargeCount==3)begin
                    seg3=charge%10;
                    seg<=segCode[seg3];
                    dp<=1;
                    an<=4'b1110;
                end
                for(integer i=0;i<16;i=i+1)begin
                    if (charge>((1000*(i+1))/16))led[i]=1;
                    else led[i]=0;
                end
                if(charge==1000)led[15]=1;
                else led[15]=0;
                railL=spriteX+1;
                railRR=spriteX+15;
                if(sw[15]&&charge==1000)begin
                    charge=0;
                    railFired=1;
                    if(railL<ballX+2&&railRR>ballX-2)begin
                        ballExists=0;
                        ballY=0;
                        ballRespawnTimer=0;
                    end
                end else begin
                    timeBetweenShots<=timeBetweenShots+1;
                    if(timeBetweenShots==100)timeBetweenShots<=0;
                end
                if(ballExists)begin
                    ballRespawnTimer<=0;
                    ballSpeedCounter<=ballSpeedCounter+1;
                    if(ballSpeedCounter>=ballSpeed&&!(sw[15]&&charge==1000)&&!(sw[15]&&charge<=5))begin
                        ballSpeedCounter<=0;
                        if(ballY<63)begin
                            ballY<=ballY+1;
                        end
                    end
                    if(ballY>=63)lost<=1;
                    if((ballX*ballX + intX*intX - 2*intX*ballX<=2) && (ballY*ballY + intY*intY - 2*intY*ballY<=2))begin
                        oled<=16'hFFFF;
                    end
                end else begin
                    ballY<=0;
                    if(ballRespawnTimer>=ballTimer)begin
                        ballRespawnTimer<=0;
                        ballExists=1;
                        ballX<=(timeBetweenShots%80)+7;
                        ballY<=0;
                    end else begin
                        ballRespawnTimer<=ballRespawnTimer+1;
                    end
                end
                if(railFired||charge<50)begin
                    railCounter<=railCounter+1;
                    if(railCounter==railDuration)begin
                        railFired<=0;
                    end
                    if(x>railL&&x<railRR&&y<=61)begin
                        railFR=255-((251*railCounterSmall)/railDurationSmall);
                        railFG=255-((103*railCounterSmall)/railDurationSmall);
                        railFB=255-((29*railCounterSmall)/railDurationSmall);
                        oled<=railFColor;
                    end
                end else begin
                    railCounter=0;
                end
                if(!(btnL^btnR))begin 
                    spriteState=0;
                    moveLeftCount=0;
                    moveRightCount=0;
                end else if(btnL)begin
                    spriteState=1;
                    moveLeftCount<=moveLeftCount+1;
                    moveRightCount=0;
                    if(moveLeftCount==doneMove)begin
                        moveLeftCount<=0;
                        if(spriteX>0)begin
                            spriteX<=spriteX-1;
                        end
                    end
                end else if(btnR)begin
                    spriteState=2;
                    moveRightCount<=moveRightCount+1;
                    moveLeftCount=0;
                    if(moveRightCount==doneMove)begin
                        moveRightCount<=0;
                        if(spriteX<79)begin
                            spriteX<=spriteX+1;
                        end
                    end
                end
                if(x>=spriteX&&y>=spriteY)begin
                    spriteOffsetX = x-spriteX;
                    spriteOffsetY = y-spriteY;
                    if(spriteOffsetX<=16&&spriteOffsetY<=16)begin
                        if(sprite!=16'h07E0&&sprite!=16'hFFFF)oled<=sprite;
                        if(sprite==16'hFFFF)begin
                            railR=255*charge/1000;
                            railG=125+(130*charge/1000);
                            railB=125+(130*charge/1000);
                            oled<=railColor;
                        end
                    end
                end
            end else begin
                oled<=gameover;
                led<=16'h0000;
                an<=4'b1111;
                dp<=1;
                seg<=7'b1111111;
            end
        end
    end
    rgb_color sky(.r(4),.g(152),.b(226),.rgbHex(skyColor));
    rgb_color_update (.clock(clock),.r(railR),.g(railG),.b(railB),.rgbHex(railColor));
    rgb_color_update (.clock(clock),.r(railFR),.g(railFG),.b(railFB),.rgbHex(railFColor));
    Get_Sprite (.pos(spriteState),.x(spriteOffsetX),.y(spriteOffsetY),.color(sprite));
    Game_Over_Image (.row(y),.column(x),.image_data(gameover));
endmodule
