`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:13:01 09/28/2015 
// Design Name: 
// Module Name:    revfunctions 
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
module RevSubBytes(
		input  wire [127:0] in,
		output wire [127:0] out);

	genvar i;
	generate
		for(i = 0; i < 128; i = i + 8) begin : URevSBox
				RevSBox U(in[i+7:i], out[i+7:i]);
			end
	endgenerate
endmodule

module RevShiftRows(
		input  wire [127:0] in,
		output wire [127:0] out);
	
	// top row shift left 0 bytes
	assign out[127:120] = in[127:120];
	assign out[95:88] = in[95:88];
	assign out[63:56] = in[63:56];
	assign out[31:24] = in[31:24];
	
	// shift left 1 byte
	assign out[87:80] = in[119:112];
	assign out[55:48] = in[87:80];
	assign out[23:16] = in[55:48];
	assign out[119:112] = in[23:16];

	// shift left 2 bytes
	assign out[47:40] = in[111:104];
	assign out[15:8] = in[79:72];
	assign out[111:104] = in[47:40];
	assign out[79:72] = in[15:8];

	// bottom row shift left 3 bytes
	assign out[7:0] = in[103:96];
	assign out[103:96] = in[71:64];
	assign out[71:64] = in[39:32];
	assign out[39:32] = in[7:0];
endmodule

module RevMixColumns(
		input  wire [127:0] in,
		output wire [127:0] out);

	genvar i;
	generate
		for(i = 0; i < 128; i = i + 32) begin : RMC
				assign out[i+31:i+24] = (in[i+31:i+24]*8'hE) + (in[i+23:i+16]*8'hB) + (in[i+15:i+8]*8'hD) + (in[i+7:i]*8'h9);
				assign out[i+23:i+16] = (in[i+31:i+24]*8'h9) + (in[i+23:i+16]*8'hE) + (in[i+15:i+8]*8'hB) + (in[i+7:i]*8'hD);
				assign out[i+15:i+8]  = (in[i+31:i+24]*8'hD) + (in[i+23:i+16]*8'h9) + (in[i+15:i+8]*8'hE) + (in[i+7:i]*8'hB);
				assign out[i+7:i]     = (in[i+31:i+24]*8'hB) + (in[i+23:i+16]*8'hD) + (in[i+15:i+8]*8'h9) + (in[i+7:i]*8'hE);
			end
	endgenerate
endmodule

//////////////////////////////////////////////////////////////////////////////////
// Sub Functions
//////////////////////////////////////////////////////////////////////////////////

module RevSBox(
		input wire [7:0] in,
		output reg [7:0] out);

	always begin
		case(in)
			8'h00: out = 8'h52;
			8'h01: out = 8'h09;
			8'h02: out = 8'h6A;
			8'h03: out = 8'hD5;
			8'h04: out = 8'h30;
			8'h05: out = 8'h36;
			8'h06: out = 8'hA5;
			8'h07: out = 8'h38;
			8'h08: out = 8'hBF;
			8'h09: out = 8'h40;
			8'h0A: out = 8'hA3;
			8'h0B: out = 8'h9E;
			8'h0C: out = 8'h81;
			8'h0D: out = 8'hF3;
			8'h0E: out = 8'hD7;
			8'h0F: out = 8'hFB;
			8'h10: out = 8'h7C;
			8'h11: out = 8'hE3;
			8'h12: out = 8'h39;
			8'h13: out = 8'h82;
			8'h14: out = 8'h9B;
			8'h15: out = 8'h2F;
			8'h16: out = 8'hFF;
			8'h17: out = 8'h87;
			8'h18: out = 8'h34;
			8'h19: out = 8'h8E;
			8'h1A: out = 8'h43;
			8'h1B: out = 8'h44;
			8'h1C: out = 8'hC4;
			8'h1D: out = 8'hDE;
			8'h1E: out = 8'hE9;
			8'h1F: out = 8'hCB;
			8'h20: out = 8'h54;
			8'h21: out = 8'h7B;
			8'h22: out = 8'h94;
			8'h23: out = 8'h32;
			8'h24: out = 8'hA6;
			8'h25: out = 8'hC2;
			8'h26: out = 8'h23;
			8'h27: out = 8'h3D;
			8'h28: out = 8'hEE;
			8'h29: out = 8'h4C;
			8'h2A: out = 8'h95;
			8'h2B: out = 8'h0B;
			8'h2C: out = 8'h42;
			8'h2D: out = 8'hFA;
			8'h2E: out = 8'hC3;
			8'h2F: out = 8'h4E;
			8'h30: out = 8'h08;
			8'h31: out = 8'h2E;
			8'h32: out = 8'hA1;
			8'h33: out = 8'h66;
			8'h34: out = 8'h28;
			8'h35: out = 8'hD9;
			8'h36: out = 8'h24;
			8'h37: out = 8'hB2;
			8'h38: out = 8'h76;
			8'h39: out = 8'h5B;
			8'h3A: out = 8'hA2;
			8'h3B: out = 8'h49;
			8'h3C: out = 8'h6D;
			8'h3D: out = 8'h8B;
			8'h3E: out = 8'hD1;
			8'h3F: out = 8'h25;
			8'h40: out = 8'h72;
			8'h41: out = 8'hF8;
			8'h42: out = 8'hF6;
			8'h43: out = 8'h64;
			8'h44: out = 8'h86;
			8'h45: out = 8'h68;
			8'h46: out = 8'h98;
			8'h47: out = 8'h16;
			8'h48: out = 8'hD4;
			8'h49: out = 8'hA4;
			8'h4A: out = 8'h5C;
			8'h4B: out = 8'hCC;
			8'h4C: out = 8'h5D;
			8'h4D: out = 8'h65;
			8'h4E: out = 8'hB6;
			8'h4F: out = 8'h92;
			8'h50: out = 8'h6C;
			8'h51: out = 8'h70;
			8'h52: out = 8'h48;
			8'h53: out = 8'h50;
			8'h54: out = 8'hFD;
			8'h55: out = 8'hED;
			8'h56: out = 8'hB9;
			8'h57: out = 8'hDA;
			8'h58: out = 8'h5E;
			8'h59: out = 8'h15;
			8'h5A: out = 8'h46;
			8'h5B: out = 8'h57;
			8'h5C: out = 8'hA7;
			8'h5D: out = 8'h8D;
			8'h5E: out = 8'h9D;
			8'h5F: out = 8'h84;
			8'h60: out = 8'h90;
			8'h61: out = 8'hD8;
			8'h62: out = 8'hAB;
			8'h63: out = 8'h00;
			8'h64: out = 8'h8C;
			8'h65: out = 8'hBC;
			8'h66: out = 8'hD3;
			8'h67: out = 8'h0A;
			8'h68: out = 8'hF7;
			8'h69: out = 8'hE4;
			8'h6A: out = 8'h58;
			8'h6B: out = 8'h05;
			8'h6C: out = 8'hB8;
			8'h6D: out = 8'hB3;
			8'h6E: out = 8'h45;
			8'h6F: out = 8'h06;
			8'h70: out = 8'hD0;
			8'h71: out = 8'h2C;
			8'h72: out = 8'h1E;
			8'h73: out = 8'h8F;
			8'h74: out = 8'hCA;
			8'h75: out = 8'h3F;
			8'h76: out = 8'h0F;
			8'h77: out = 8'h02;
			8'h78: out = 8'hC1;
			8'h79: out = 8'hAF;
			8'h7A: out = 8'hBD;
			8'h7B: out = 8'h03;
			8'h7C: out = 8'h01;
			8'h7D: out = 8'h13;
			8'h7E: out = 8'h8A;
			8'h7F: out = 8'h6B;
			8'h80: out = 8'h3A;
			8'h81: out = 8'h91;
			8'h82: out = 8'h11;
			8'h83: out = 8'h41;
			8'h84: out = 8'h4F;
			8'h85: out = 8'h67;
			8'h86: out = 8'hDC;
			8'h87: out = 8'hEA;
			8'h88: out = 8'h97;
			8'h89: out = 8'hF2;
			8'h8A: out = 8'hCF;
			8'h8B: out = 8'hCE;
			8'h8C: out = 8'hF0;
			8'h8D: out = 8'hB4;
			8'h8E: out = 8'hE6;
			8'h8F: out = 8'h73;
			8'h90: out = 8'h96;
			8'h91: out = 8'hAC;
			8'h92: out = 8'h74;
			8'h93: out = 8'h22;
			8'h94: out = 8'hE7;
			8'h95: out = 8'hAD;
			8'h96: out = 8'h35;
			8'h97: out = 8'h85;
			8'h98: out = 8'hE2;
			8'h99: out = 8'hF9;
			8'h9A: out = 8'h37;
			8'h9B: out = 8'hE8;
			8'h9C: out = 8'h1C;
			8'h9D: out = 8'h75;
			8'h9E: out = 8'hDF;
			8'h9F: out = 8'h6E;
			8'hA0: out = 8'h47;
			8'hA1: out = 8'hF1;
			8'hA2: out = 8'h1A;
			8'hA3: out = 8'h71;
			8'hA4: out = 8'h1D;
			8'hA5: out = 8'h29;
			8'hA6: out = 8'hC5;
			8'hA7: out = 8'h89;
			8'hA8: out = 8'h6F;
			8'hA9: out = 8'hB7;
			8'hAA: out = 8'h62;
			8'hAB: out = 8'h0E;
			8'hAC: out = 8'hAA;
			8'hAD: out = 8'h18;
			8'hAE: out = 8'hBE;
			8'hAF: out = 8'h1B;
			8'hB0: out = 8'hFC;
			8'hB1: out = 8'h56;
			8'hB2: out = 8'h3E;
			8'hB3: out = 8'h4B;
			8'hB4: out = 8'hC6;
			8'hB5: out = 8'hD2;
			8'hB6: out = 8'h79;
			8'hB7: out = 8'h20;
			8'hB8: out = 8'h9A;
			8'hB9: out = 8'hDB;
			8'hBA: out = 8'hC0;
			8'hBB: out = 8'hFE;
			8'hBC: out = 8'h78;
			8'hBD: out = 8'hCD;
			8'hBE: out = 8'h5A;
			8'hBF: out = 8'hF4;
			8'hC0: out = 8'h1F;
			8'hC1: out = 8'hDD;
			8'hC2: out = 8'hA8;
			8'hC3: out = 8'h33;
			8'hC4: out = 8'h88;
			8'hC5: out = 8'h07;
			8'hC6: out = 8'hC7;
			8'hC7: out = 8'h31;
			8'hC8: out = 8'hB1;
			8'hC9: out = 8'h12;
			8'hCA: out = 8'h10;
			8'hCB: out = 8'h59;
			8'hCC: out = 8'h27;
			8'hCD: out = 8'h80;
			8'hCE: out = 8'hEC;
			8'hCF: out = 8'h5F;
			8'hD0: out = 8'h60;
			8'hD1: out = 8'h51;
			8'hD2: out = 8'h7F;
			8'hD3: out = 8'hA9;
			8'hD4: out = 8'h19;
			8'hD5: out = 8'hB5;
			8'hD6: out = 8'h4A;
			8'hD7: out = 8'h0D;
			8'hD8: out = 8'h2D;
			8'hD9: out = 8'hE5;
			8'hDA: out = 8'h7A;
			8'hDB: out = 8'h9F;
			8'hDC: out = 8'h93;
			8'hDD: out = 8'hC9;
			8'hDE: out = 8'h9C;
			8'hDF: out = 8'hEF;
			8'hE0: out = 8'hA0;
			8'hE1: out = 8'hE0;
			8'hE2: out = 8'h3B;
			8'hE3: out = 8'h4D;
			8'hE4: out = 8'hAE;
			8'hE5: out = 8'h2A;
			8'hE6: out = 8'hF5;
			8'hE7: out = 8'hB0;
			8'hE8: out = 8'hC8;
			8'hE9: out = 8'hEB;
			8'hEA: out = 8'hBB;
			8'hEB: out = 8'h3C;
			8'hEC: out = 8'h83;
			8'hED: out = 8'h53;
			8'hEE: out = 8'h99;
			8'hEF: out = 8'h61;
			8'hF0: out = 8'h17;
			8'hF1: out = 8'h2B;
			8'hF2: out = 8'h04;
			8'hF3: out = 8'h7E;
			8'hF4: out = 8'hBA;
			8'hF5: out = 8'h77;
			8'hF6: out = 8'hD6;
			8'hF7: out = 8'h26;
			8'hF8: out = 8'hE1;
			8'hF9: out = 8'h69;
			8'hFA: out = 8'h14;
			8'hFB: out = 8'h63;
			8'hFC: out = 8'h55;
			8'hFD: out = 8'h21;
			8'hFE: out = 8'h0C;
			8'hFF: out = 8'h7D;
		endcase
	end
endmodule

