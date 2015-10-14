`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:04:48 09/28/2015 
// Design Name: 
// Module Name:    revrounds 
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
module RevInitialRound(
		input  wire [127:0] in,
		input  wire [127:0] key,
		output wire [127:0] out);

	wire [127:0] tmp [0:1];

	AddRoundKey  U1(in, key, tmp[0]);
	RevShiftRows U2(tmp[0],  tmp[1]);
	RevSubBytes  U3(tmp[1],  out);
endmodule

module RevRound(
		input  wire [127:0] in,
		input  wire [127:0] key,
		output wire [127:0] out);

	wire [127:0] tmp [0:2];

	AddRoundKey   U1(in, key, tmp[0]);
	RevMixColumns U2(tmp[0],  tmp[1]);
	RevShiftRows  U3(tmp[1],  tmp[2]);
	RevSubBytes   U4(tmp[2],  out);
endmodule

module RevFinalRound(
		input  wire [127:0] in,
		input  wire [127:0] key,
		output wire [127:0] out);

	AddRoundKey U1(in, key, out);
endmodule
