`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 19:00:41
// Design Name: 
// Module Name: top_tb
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


module top_tb;
    reg clk_in;
    reg reset;
    wire clk;
    wire [31:0]pc;
    wire [31:0]inst;
//    wire [31:0]addr;
//    wire [31:0]rdata;
//    wire [31:0]wdata;
    wire IM_R;
    wire DM_CS;
    wire DM_R;
    wire DM_W;
    
//    wire [31:0]rf_rdata1;
//    wire [31:0]rf_rdata2;
//    wire [31:0]rf_wdata;
    wire [31:0]alu_r;
//    wire [2:0]alu_c;
//    wire [31:0]m1_out;    
//    wire [31:0]m2_out;    
//    wire [31:0]m3_out;
//    wire [31:0]m4_out;
//    wire [31:0]m5_out;    
//    wire [4:0]m6_out;
//    wire z;
    top uut(clk_in,reset,clk,pc,inst,addr,rdata,wdata,IM_R,DM_CS,DM_R,DM_W,alu_r);
    initial
        begin
        clk_in = 0;
        reset = 1;
        #100;
        reset=0;
        forever
            #100
            clk_in = ~clk_in;
        end

endmodule