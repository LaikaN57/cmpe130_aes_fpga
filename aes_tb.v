`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2015 09:43:58 PM
// Design Name: 
// Module Name: aes_tb
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

/*
module aes_encrypt(
		input  wire [127:0] plaintext,
		input  wire [127:0] key,
		output wire [127:0] ciphertext);*/
		
module aes_tb;
    reg [127*8:0] text; //to store the string to encrypt/decrypt
    
    
    aes_encrypt(.plaintext(text), .key(key), .ciphertext(ciphertext));
    initial begin
        text = "Hello my name is Mina";
       
       $display("%s", text);
       
    end
endmodule
