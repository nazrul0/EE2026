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
    output reg [11:0] led
    );
    
    wire clk20K;
    unit_clk my_20KHz_clk(clock, 2499, clk20K);
    
    always @ (posedge clk20K)
    begin
    
    if (peak_intensity <= 4096 && peak_intensity > 3869)
    begin
        led[8:0] <= 9'b111111111;
    end
            
    else if (peak_intensity <= 3869 && peak_intensity > 3642)
    begin
        led[8:0] <= 9'b011111111;
    end
            
    else if (peak_intensity <= 3642 && peak_intensity > 3415)
    begin
        led[8:0] <= 9'b001111111;
    end
            
    else if (peak_intensity <= 3415 && peak_intensity > 3188)
    begin
        led[8:0] <= 9'b000111111;
    end
            
    else if (peak_intensity <= 3188 && peak_intensity > 2961)
    begin
        led[8:0] <= 9'b000011111;
    end
            
    else if (peak_intensity <= 2961 && peak_intensity > 2734)
    begin
        led[8:0] <= 9'b000001111;
    end
            
    else if (peak_intensity <= 2734 && peak_intensity > 2507)
    begin
        led[8:0] <= 9'b000000111;
    end
            
    else if (peak_intensity <= 2507 && peak_intensity > 2280)
    begin
        led[8:0] <= 9'b000000011;
    end
            
    else if (peak_intensity <= 2280 && peak_intensity > 2053)
    begin
        led[8:0] <= 9'b000000001;
    end
                
    else if (peak_intensity <= 2053)
    begin
        led[8:0] <= 9'b000000000;
    end
    
    end
    
endmodule
