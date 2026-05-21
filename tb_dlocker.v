`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 11:38:16
// Design Name: 
// Module Name: tb_dlocker
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


module tb_dlocker();

reg clk, rst, p_in, submit;
wire unlock;


initial {clk,rst,p_in,submit} = 0;

dlocker uut(clk,rst,p_in,submit,unlock);

always #2 clk = ~clk;

initial begin
@(negedge clk)
rst = 1;
@(negedge clk)
rst = 0;
p_in = 1;
@(negedge clk)
p_in = 1;
@(negedge clk)
p_in = 0;
@(negedge clk)
p_in = 0;
@(negedge clk)
submit = 1;
@(negedge clk)
submit = 0;

@(negedge clk)
p_in = 1;
@(negedge clk)
p_in = 1;
@(negedge clk)
p_in = 0;
@(negedge clk)
p_in = 0;
@(negedge clk)
submit = 1;
@(negedge clk)
submit = 0;
p_in = 1;
@(negedge clk)
p_in = 1;
@(negedge clk)
p_in = 0;
@(negedge clk)
p_in = 1;
@(negedge clk)
p_in = 0;
submit = 1;
@(negedge clk)
submit = 0;





end




endmodule
