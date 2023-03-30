`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2023 18:01:09
// Design Name: 
// Module Name: naz_ld_control
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


module naz_ld_control(
    input clock,
    input [11:0] peak_intensity,
    output reg [15:0] led,
    input [31:0] frequency,
    input [15:0] sw,
    input [31:0] number,
    output reg [4:0] vol_level = 0,
    output reg [15:0] team_led_new
    );
    
    wire clk20K;
    unit_clk my_20KHz_clk(clock, 2499, clk20K);
    
//    wire [15:0] team_led_output;
//    team_ld_control team_ld_display(.clock(clock), .peak_intensity(peak_intensity), .led(team_led_output), .sw(sw), .number(number));    
    
    
    always @ (posedge clk20K)
    begin
    
    if (sw[2] == 0)
    begin

        for(integer i=0;i<16;i=i+1)led[i]<=0;        
        if (peak_intensity <= 4096 && peak_intensity > 3869)
        begin
            led[8:0] <= 9'b111111111;
            vol_level = 9;
        end
                
        else if (peak_intensity <= 3869 && peak_intensity > 3642)
        begin
            led[8:0] <= 9'b011111111;
            vol_level = 8;
        end
            
        else if (peak_intensity <= 3642 && peak_intensity > 3415)
        begin
            led[8:0] <= 9'b001111111;
            vol_level = 7;
        end
                
        else if (peak_intensity <= 3415 && peak_intensity > 3188)
        begin
            led[8:0] <= 9'b000111111;
            vol_level = 6;
        end
                
        else if (peak_intensity <= 3188 && peak_intensity > 2961)
        begin
            led[8:0] <= 9'b000011111;
            vol_level = 5;
        end
                
        else if (peak_intensity <= 2961 && peak_intensity > 2734)
        begin
            led[8:0] <= 9'b000001111;
            vol_level = 4;
        end
                
        else if (peak_intensity <= 2734 && peak_intensity > 2507)
        begin
            led[8:0] <= 9'b000000111;
            vol_level = 3;
        end
                
        else if (peak_intensity <= 2507 && peak_intensity > 2280)
        begin
            led[8:0] <= 9'b000000011;
            vol_level = 2;
        end
                
        else if (peak_intensity <= 2280 && peak_intensity > 2053)
        begin
            led[8:0] <= 9'b000000001;
            vol_level = 1;
        end
                
        else if (peak_intensity <= 2053)
        begin
            led[8:0] <= 9'b000000000;
            vol_level = 0;
        end
    end
    
    else if (sw[2] == 1)
    begin
        if (frequency >= 500 && frequency < 1000)
        begin
            led[15:0] <= 16'b0000_0000_0000_0001;
        end
        
        else if (frequency >= 1000 && frequency < 1500)
        begin
            led[15:0] <= 16'b0000_0000_0000_0011;
        end
        
        else if (frequency >= 1500 && frequency < 2000)
        begin
            led[15:0] <= 16'b0000_0000_0000_0111;
        end
        
        else if (frequency >= 2000 && frequency < 2500)
        begin
            led[15:0] <= 16'b0000_0000_0000_1111;
        end
        
        else if (frequency >= 2500 && frequency < 3000)
        begin
            led[15:0] <= 16'b0000_0000_0001_1111;
        end
        
        else if (frequency >= 3000 && frequency < 3500)
        begin
            led[15:0] <= 16'b0000_0000_0011_1111;
        end
        
        else if (frequency >= 3500 && frequency < 4000)
        begin
            led[15:0] <= 16'b0000_0000_0111_1111;
        end
        
        else if (frequency >= 4000 && frequency < 4500)
        begin
            led[15:0] <= 16'b0000_0000_1111_1111;
        end
        
        else if (frequency >= 4500 && frequency < 5000)
        begin
            led[15:0] <= 16'b0000_0001_1111_1111;
        end
        
        else if (frequency >= 5000 && frequency < 5500)
        begin
            led[15:0] <= 16'b0000_0011_1111_1111;
        end      
        
        else if (frequency >= 5500 && frequency < 6000)
        begin
            led[15:0] <= 16'b0000_0111_1111_1111;
        end 
        
        else if (frequency >= 6000 && frequency < 6500)
        begin
            led[15:0] <= 16'b0000_1111_1111_1111;
        end 
        
        else if (frequency >= 6500 && frequency < 7000)
        begin
            led[15:0] <= 16'b0001_1111_1111_1111;
        end 
        
        else if (frequency >= 7000 && frequency < 7500)
        begin
            led[15:0] <= 16'b0011_1111_1111_1111;
        end 
        
        else if (frequency >= 7500 && frequency < 8000)
        begin
            led[15:0] <= 16'b0111_1111_1111_1111;
        end 
        
        else if (frequency >= 8000)
        begin
            led[15:0] <= 16'b1111_1111_1111_1111;
        end                                                                                                                   
    end
    
    if (sw[3] == 1)
    begin
        led[15:0] <= 16'b0000_0000_0000_0000;
    end
   
    
    end
    
endmodule


//        if (peak_intensity <= 4096 && peak_intensity > 3869)
    //        begin
    //            led[15:0] <= 16'b0000_0001_1111_1111;
    //        end
                    
    //        else if (peak_intensity <= 3869 && peak_intensity > 3642)
    //        begin
    //            led[15:0] <= 16'b0000_0000_1111_1111;
    //        end
                
    //        else if (peak_intensity <= 3642 && peak_intensity > 3415)
    //        begin
    //            led[15:0] <= 16'b0000_0000_0111_1111;
    //        end
                    
    //        else if (peak_intensity <= 3415 && peak_intensity > 3188)
    //        begin
    //            led[15:0] <= 16'b0000_0000_0011_1111;
    //        end
                    
    //        else if (peak_intensity <= 3188 && peak_intensity > 2961)
    //        begin
    //            led[15:0] <= 16'b0000_0000_0001_1111;
    //        end
                    
    //        else if (peak_intensity <= 2961 && peak_intensity > 2734)
    //        begin
    //            led[15:0] <= 16'b0000_0000_0000_1111;
    //        end
                    
    //        else if (peak_intensity <= 2734 && peak_intensity > 2507)
    //        begin
    //            led[15:0] <= 16'b0000_0000_0000_0111;
    //        end
                    
    //        else if (peak_intensity <= 2507 && peak_intensity > 2280)
    //        begin
    //            led[15:0] <= 16'b0000_0000_0000_0011;
    //        end
                    
    //        else if (peak_intensity <= 2280 && peak_intensity > 2053)
    //        begin
    //            led[15:0] <= 16'b0000_0000_0000_0001;
    //        end
                    
    //        else if (peak_intensity <= 2053)
    //        begin
    //            led[15:0] <= 16'b0000_0000_0000_0000;
    //        end
