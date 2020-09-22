`include "defines.v"

module inst_rom(

//	input	wire										clk,
	input wire										ce,
	input wire[`InstAddrBus]			addr,
	output reg[`InstBus]					inst
	
);

	reg[`InstBus]  inst_mem[0:`InstMemNum-1];

//	initial $readmemh ( "C:/Users/WSH/Desktop/inst_rom7.txt", inst_mem );
    initial begin
        inst_mem[0] = 32'h3401ffff;
        inst_mem[1] = 32'h00010c00;
        inst_mem[2] = 32'h3421fffb;
        inst_mem[3] = 32'h34020006;
        inst_mem[4] = 32'h00220018;
        inst_mem[5] = 32'h70220000;
        inst_mem[6] = 32'h70220001;
        inst_mem[7] = 32'h70220004;
        inst_mem[8] = 32'h70220005;
    end

	always @ (*) begin
		if (ce == `ChipDisable) begin
			inst <= `ZeroWord;
	  end else begin
		  inst <= inst_mem[addr[`InstMemNumLog2+1:2]];
		end
	end

endmodule