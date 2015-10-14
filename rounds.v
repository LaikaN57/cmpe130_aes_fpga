`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:56:47 09/28/2015 
// Design Name: 
// Module Name:    rounds 
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
module InitialRound(
		input  wire [127:0] in,
		input  wire [127:0] key,
		output wire [127:0] out);

	AddRoundKey U1(in, key, out);
endmodule

module Round(
		input  wire [127:0] in,
		input  wire [127:0] key,
		output wire [127:0] out);

	wire [127:0] tmp [0:2];

	SubBytes    U1(in,          tmp[0]);
	ShiftRows   U2(tmp[0],      tmp[1]);
	MixColumns  U3(tmp[1],      tmp[2]);
	AddRoundKey U4(tmp[2], key, out);
endmodule

module FinalRound(
		input  wire [127:0] in,
		input  wire [127:0] key,
		output wire [127:0] out);

	wire [127:0] tmp [0:1];

	SubBytes    U1(in,          tmp[0]);
	ShiftRows   U2(tmp[0],      tmp[1]);
	AddRoundKey U3(tmp[1], key, out);
endmodule
