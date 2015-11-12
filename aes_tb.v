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
    reg [127:0] text ; //to store the string to encrypt/decrypt
    reg [127:0] key;
    wire [127:0] ciphertext, dText;
    
    aes_encrypt m1(.plaintext(text), .key(key), .ciphertext(ciphertext));
    aes_decrypt m2(.plaintext(ciphertext), .key(key), .ciphertext(dText));
    initial begin
        text = 48'b010010000110010101101100011011000110111100100001; //Hello!
        key = 32'b01101011011001010111100100001010; //key
       
       $display("%s %s", text, key);
       $display("%s %s", ciphertext, dText);

    end
endmodule
