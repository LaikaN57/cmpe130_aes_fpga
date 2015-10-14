`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:17:06 09/28/2015 
// Design Name: 
// Module Name:    aes_decrypt 
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
module aes_decrypt(
		 input  wire [127:0] ciphertext,
		 input  wire [127:0] key,
		 output wire [127:0] plaintext);

	wire [127:0] states  [0:9];  // 10 states
	wire [127:0] subkeys [0:10]; // 11 keys

	KeyExpansion U1(
			key,
			{subkeys[0],   // well
			subkeys[1],   // this
			subkeys[2],   // blows
			subkeys[3],   // but
			subkeys[4],   // it
			subkeys[5],   // is
			subkeys[6],   // better
			subkeys[7],   // than
			subkeys[8],   // flattening
			subkeys[9],   // the
			subkeys[10]}); // array

	RevInitialRound U2(ciphertext, subkeys[10], states[0]);
	
	genvar i;
	generate
		for(i = 0; i < 9; i = i + 1) begin : URound
				RevRound U(states[i], subkeys[9-i], states[i+1]);
			end
	endgenerate
	
	RevFinalRound U12(states[9], subkeys[0], plaintext);

endmodule
