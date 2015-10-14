`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:33:37 09/28/2015 
// Design Name: 
// Module Name:    KeyExpansion 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module KeyExpansion(
		 input  wire [127:0] key,
		 output wire [1407:0] subkeys);

	wire [1407:0] afterrotword;
	wire [1407:0] aftersubword;
	//wire [1407:0] roundconsts;
	wire [1407:0] afterxorwithroundconst;
		 
	// make some key babys
	assign subkeys[127:0] = key;
	
	// only on mod 4 words
	assign afterxorwithroundconst = aftersubword ^ { // roundconsts
			32'h00000000, 32'h0, 32'h0, 32'h0,
			32'h01000000, 32'h0, 32'h0, 32'h0,
			32'h02000000, 32'h0, 32'h0, 32'h0,
			32'h04000000, 32'h0, 32'h0, 32'h0,
			32'h08000000, 32'h0, 32'h0, 32'h0,
			32'h10000000, 32'h0, 32'h0, 32'h0,
			32'h20000000, 32'h0, 32'h0, 32'h0,
			32'h40000000, 32'h0, 32'h0, 32'h0,
			32'h80000000, 32'h0, 32'h0, 32'h0,
			32'h1b000000, 32'h0, 32'h0, 32'h0,
			32'h36000000, 32'h0, 32'h0, 32'h0};
	
	genvar i;
	generate
		for(i = 4; i < 44; i = i + 1) begin : KE
			if(i % 4 == 0) begin
				RotWord RU(subkeys[(i-1)*32+31:(i-1)*32], afterrotword[i*32+31:i*32]);
				SubWord SU(afterrotword[i*32+31:i*32], aftersubword[i*32+31:i*32]);
				assign subkeys[i*32+31:i*32] = afterxorwithroundconst[i*32+31:i*32] ^ subkeys[(i-4)*32+31:(i-4)*32];
			end else begin
				// this byte = last byte ^ 4 bytes ago
				assign subkeys[i*32+31:i*32] = subkeys[(i-1)*32+31:(i-1)*32] ^ subkeys[(i-4)*32+31:(i-4)*32];
			end
		end
	endgenerate

endmodule

module SubWord(
		input  wire [31:0] in,
		output wire [31:0] out);
	SubBytes U1(in[31:24], out[31:24]);
	SubBytes U2(in[23:16], out[23:16]);
	SubBytes U3(in[15:8],  out[15:8]);
	SubBytes U4(in[7:0],   out[7:0]);
endmodule

module RotWord(
		input  wire [31:0] in,
		output wire [31:0] out);
	assign out = {in[23:0], in[31:24]};
endmodule
