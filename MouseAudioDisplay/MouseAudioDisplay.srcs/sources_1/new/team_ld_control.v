`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 22:50:05
// Design Name: 
// Module Name: team_ld_control
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


module team_ld_control(
    input clock,
    input [11:0] peak_intensity,
    output reg [15:0] led,
    input [15:0] sw,
    input [31:0] number
    );
    
    wire clk20K;
    unit_clk my_20KHz_clk(clock, 2499, clk20K);
    
    always @ (posedge clk20K)
    begin
    
        for(integer i=0;i<16;i=i+1)led[i]<=0;
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
        if(sw[15])begin
            led[15]<=number<10?1:0;
        end else begin
            led[15]<=0;
        end
    end

    
endmodule
