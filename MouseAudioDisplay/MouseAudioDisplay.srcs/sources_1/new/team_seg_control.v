`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 22:53:41
// Design Name: 
// Module Name: team_seg_control
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


module team_seg_control(
    input clock,
    input [11:0] peak_intensity,
    input [15:0] sw,
    output reg [3:0] an,
    output reg [6:0] seg,
    output reg dp = ~0,
    input [31:0] number
    );
    
    reg [6:0] segCode [9:0];

    always @ (posedge clock)
    begin
    segCode[0] <= ~7'b0111111;
    segCode[1] <= ~7'b0000110;
    segCode[2] <= ~7'b1011011;
    segCode[3] <= ~7'b1001111;
    segCode[4] <= ~7'b1100110;
    segCode[5] <= ~7'b1101101;
    segCode[6] <= ~7'b1111101;
    segCode[7] <= ~7'b0000111;
    segCode[8] <= ~7'b1111111;
    segCode[9] <= ~7'b1101111;
    end
    
    
    wire clk20K;
    unit_clk my_20KHz_clk(clock,2499, clk20K);
    
    wire clk1K;
    unit_clk my_1KHz_clk(clock, 49999, clk1K);
    
    reg [3:0] an_selector = 0;
    always @ (posedge clk1K)
    begin
        an_selector <= (an_selector == 3) ? 0 : an_selector + 1;
    end
    
    reg [6:0] an1, an2, an3;
    always @ (posedge clk20K)
    begin
        // assign an3 and an2 here for each valid number. in the next block, assign for each an_selector value
        
        if (number == 0)
        begin
            an3 <= segCode[0];
            an2 <= segCode[1];
        end
        
        if (number == 1)
        begin
            an3 <= segCode[0];
            an2 <= segCode[2];
        end        
        
        if (number == 2)
        begin
            an3 <= segCode[0];
            an2 <= segCode[3];
        end        
       
        if (number == 3)
        begin
            an3 <= segCode[0];
            an2 <= segCode[4];
        end         
        
        if (number == 4)
        begin
            an3 <= segCode[0];
            an2 <= segCode[5];
        end        
        
        if (number == 5)
        begin
            an3 <= segCode[0];
            an2 <= segCode[6];
        end        
        
        if (number == 6)
        begin
            an3 <= segCode[0];
            an2 <= segCode[7];
        end        
        
        if (number == 7)
        begin
            an3 <= segCode[0];
            an2 <= segCode[8];
        end        
        
        if (number == 8)
        begin
            an3 <= segCode[0];
            an2 <= segCode[9];
        end        
        
        if (number == 9)
        begin
            an3 <= segCode[1];
            an2 <= segCode[0];
        end        
    end
    
    
    always @ (posedge clk20K)
    begin
        
    if (number < 10 && an_selector == 2)
    begin
    an[3:0] <= ~4'b0100;
    seg[6:0] <= an2;
    dp = ~0;
    end

    else if (number < 10 && an_selector == 3)
    begin
    an[3:0] <= ~4'b1000;
    seg[6:0] <= an3;   
    dp <= ~1; 
    end
    
    if (number == 10 && an_selector == 2)
    begin
    an[3:0] <= ~4'b0100;
    seg[6:0] <= ~7'b0000000;   
    dp <= ~0;     
    end

    if (number == 10 && an_selector == 3)
    begin
    an[3:0] <= ~4'b1000;
    seg[6:0] <= ~7'b0000000;   
    dp <= ~0;     
    end        
    
    if (peak_intensity <= 4096 && peak_intensity > 3869)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b1100111;
            dp <= ~0;
            end
                                   
        end
            
    else if (peak_intensity <= 3869 && peak_intensity > 3642)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b1111111;
            dp <= ~0;
            end
          
        end
            
    else if (peak_intensity <= 3642 && peak_intensity > 3415)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b0000111;
            dp <= ~0;
            end
         
        end
            
    else if (peak_intensity <= 3415 && peak_intensity > 3188)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b1111101;
            dp <= ~0;
            end
        
        end
            
    else if (peak_intensity <= 3188 && peak_intensity > 2961)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b1101101;
            dp <= ~0;
            end
             
        end
            
    else if (peak_intensity <= 2961 && peak_intensity > 2734)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b1100110;
            dp <= ~0;
            end
           
        end
            
    else if (peak_intensity <= 2734 && peak_intensity > 2507)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b1001111;
            dp <= ~0;
            end
          
        end
            
    else if (peak_intensity <= 2507 && peak_intensity > 2280)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b1011011;
            dp <= ~0;
            end
          
        end
            
    else if (peak_intensity <= 2280 && peak_intensity > 2053)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b0000110;
            dp <= ~0;
            end
       
        end
                
    else if (peak_intensity <= 2053)
        begin
            if (an_selector == 0)
            begin
            an[3:0] <= ~4'b0001;
            seg[6:0] <= ~7'b0111111;
            dp <= ~0;
            end
         
        end
    
    end
    
endmodule
