`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2023 14:27:51
// Design Name: 
// Module Name: sim_clock
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


module sim_clock(
        
    );
    
    reg input_clk;
    wire sim_clock;
    
    
    unit_clk_20KHz sim_20K(input_clk, sim_clock);
    
    initial begin
      input_clk = 0;
    end
    
    always begin
      #5 input_clk = ~input_clk;
    end
    
endmodule
