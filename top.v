`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:22:59 09/28/2015 
// Design Name: 
// Module Name:    top 
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

/*

IMPORTANT

all matricies are in the following order
[ 127:120 95:88 63:56 31:24 ]
[ 119:112 87:80 55:48 23:16 ]
[ 111:104 79:72 47:40 15:8  ]
[ 103:96  71:64 39:32  7:0  ]


*/
module top(
		input  wire     mode);

		supply0 [127:0] in;
		supply0 [127:0] key;
		reg  [127:0] out;
	 
	wire [127:0] ciphertext;
	wire [127:0] plaintext;

	aes_encrypt U1(in, key, ciphertext);
	aes_decrypt U2(in, key, plaintext);

	always begin
		out = mode ? ciphertext : plaintext;
	end
endmodule
