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

All matricies are in the following order:

bytes
[  0  4  8 12 ]
[  1  5  9 13 ]
[  2  6 10 14 ]
[  3  7 11 15 ]

bits
[   7:0    39:32   71:64  103:96  ]
[  15:8    47:40   79:72  111:104 ]
[  23:16   55:48   87:80  119:112 ]
[  31:24   63:56   95:88  127:120 ]

Therefore row 0 is made up of bytes 0, 4, 8, and 12.
This coorosponds to bits 7:0, 39:32, 71:64, and 103:96.

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
