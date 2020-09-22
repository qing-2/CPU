//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2014 leishangwen@163.com                       ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// Module:  openmips_min_sopc
// File:    openmips_min_sopc.v
// Author:  Lei Silei
// E-mail:  leishangwen@163.com
// Description: 基于OpenMIPS处理器的一个简单SOPC，用于验证具备了
//              wishbone总线接口的openmips，该SOPC包含openmips、
//              wb_conmax、GPIO controller、flash controller，uart 
//              controller，以及用来仿真flash的模块flashmem，在其中
//              存储指令，用来仿真外部ram的模块datamem，在其中存储
//              数据，并且具有wishbone总线接口    
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module openmips_min_sopc(

	input	clk,
	input   rst,
	output [7:0] an,
	output [6:0] sseg
	
);

  //连接指令存储器
  wire[`InstAddrBus] inst_addr;
  wire[`InstBus] inst;
  wire rom_ce;
//  wire [7:0] an;
//  wire [6:0] sseg;
    reg[40:0] cnt;
    parameter N=100000000; 
    reg clk_div=1'b0;
    always@(posedge clk)
        if(cnt<N)
            cnt<=cnt+1;
         else begin
            cnt<=1'b0;
            clk_div=~clk_div;
          end
 openmips openmips0(
		.clk(clk_div),
		.rst(rst),
	
		.rom_addr_o(inst_addr),
		.rom_data_i(inst),
		.rom_ce_o(rom_ce)
	
	);
	
	inst_rom inst_rom0(
		.ce(rom_ce),
		.addr(inst_addr),
		.inst(inst)	
	);
    disp(
        .clk(clk),      
        .clk_div(clk_div),
        .num(inst_addr[7:0]),
        .an(an),//8位数码管的状态，低电平有效
        .sseg(sseg)
        );

endmodule