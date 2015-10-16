`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:11 10/16/2015 
// Design Name: 
// Module Name:    spi 
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
module spi(
		input  wire sck,
		input  wire mosi,
		output reg  miso,
		input  wire cs,
		input  reg [383:0] in,
		output reg [127:0] out);

reg [8:0] count; // 9-bit counter / 512

always @(negedge cs) begin
	count = 0;
end

always @(posedge sck) begin
	if(cs) begin
		if(count < 256) begin
			in[255 - count] = mosi;
		end else begin
			miso = out[127 - (count - 256)];
		end
		
		count = (count + 1) % 384;
	end
end

endmodule