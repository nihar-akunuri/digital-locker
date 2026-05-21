`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.05.2025 11:05:10
// Design Name: 
// Module Name: dlocker
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


module dlocker(input clk, rst, p_in, submit, output reg unlock);

parameter idle = 3'd0;
parameter s1 = 3'd1;
parameter s2 = 3'd2;
parameter s3 = 3'd3;
parameter s4 = 3'd4;
parameter err = 3'd5;
parameter lock = 3'd6;

reg [2:0]ps,ns;
reg[1:0]ecount = 0;

always @(posedge clk) begin
    if(rst) begin 
    ps <= idle;
    ecount <= 0;
    end 
    else if(ecount == 3)
    ps <= lock;
    else
    ps <= ns;
end 

always @(*) begin

case(ps) 
lock: ns = lock;
idle: begin
    if(p_in)
    ns = s1;
    else if(submit)
    ns = idle;
    else begin
    ns = err;
    end
end
s1: begin
    if(p_in)
    ns = s2;
    else begin 
    ns = err;
    end 
end  
s2: begin 
    if(!p_in)
    ns = s3;
    else begin  
    ns = err;
    end 
end 
s3: begin
    if(p_in)
    ns = s4;
    else begin  
    ns = err;
    end 
end 
s4: begin
    if(submit)
    ns = idle;
    else
    ns = s4;
end 
err: begin
    if(submit) begin    
    ns = idle;
    end 
    else
    ns = err;
end 
endcase
end 


always @(posedge clk) begin
unlock <= 0;

if((ps == err) && submit) begin
ecount = ecount + 1;
end 

if((ps == s4) && submit) begin  
unlock <= 1;
ecount = 0;
end 
end 


endmodule
