// Verilog module
module matrix_multiplier#(
    parameter ROWS = 3,
    parameter COLS = 3,
    parameter MEM_SIZE = 93,
    parameter input_bit_width = 3,
    parameter output_bit_width = 16
)(
    input wire [input_bit_width-1:0] input_vector [0: COLS-1],
    output wire [output_bit_width-1:0] output_vector [0: ROWS-1]
);

wire [output_bit_width-1:0] MEM [0:MEM_SIZE];

assign MEM[0] = -(input_vector[0] << 15);
assign MEM[1] = input_vector[0] << 14;
assign MEM[2] = input_vector[0] << 13;
assign MEM[3] = input_vector[0] << 12;
assign MEM[4] = input_vector[0] << 11;
assign MEM[5] = input_vector[0] << 10;
assign MEM[6] = input_vector[0] << 9;
assign MEM[7] = input_vector[0] << 8;
assign MEM[8] = input_vector[0] << 7;
assign MEM[9] = input_vector[0] << 6;
assign MEM[10] = input_vector[0] << 5;
assign MEM[11] = input_vector[0] << 4;
assign MEM[12] = input_vector[0] << 3;
assign MEM[13] = input_vector[0] << 2;
assign MEM[14] = input_vector[0] << 1;
assign MEM[15] = input_vector[0] << 0;
assign MEM[16] = -(input_vector[1] << 15);
assign MEM[17] = input_vector[1] << 14;
assign MEM[18] = input_vector[1] << 13;
assign MEM[19] = input_vector[1] << 12;
assign MEM[20] = input_vector[1] << 11;
assign MEM[21] = input_vector[1] << 10;
assign MEM[22] = input_vector[1] << 9;
assign MEM[23] = input_vector[1] << 8;
assign MEM[24] = input_vector[1] << 7;
assign MEM[25] = input_vector[1] << 6;
assign MEM[26] = input_vector[1] << 5;
assign MEM[27] = input_vector[1] << 4;
assign MEM[28] = input_vector[1] << 3;
assign MEM[29] = input_vector[1] << 2;
assign MEM[30] = input_vector[1] << 1;
assign MEM[31] = input_vector[1] << 0;
assign MEM[32] = -(input_vector[2] << 15);
assign MEM[33] = input_vector[2] << 14;
assign MEM[34] = input_vector[2] << 13;
assign MEM[35] = input_vector[2] << 12;
assign MEM[36] = input_vector[2] << 11;
assign MEM[37] = input_vector[2] << 10;
assign MEM[38] = input_vector[2] << 9;
assign MEM[39] = input_vector[2] << 8;
assign MEM[40] = input_vector[2] << 7;
assign MEM[41] = input_vector[2] << 6;
assign MEM[42] = input_vector[2] << 5;
assign MEM[43] = input_vector[2] << 4;
assign MEM[44] = input_vector[2] << 3;
assign MEM[45] = input_vector[2] << 2;
assign MEM[46] = input_vector[2] << 1;
assign MEM[47] = input_vector[2] << 0;
assign MEM[48] = MEM[28] + MEM[32];
assign MEM[49] = MEM[34] + MEM[48];
assign MEM[50] = MEM[4] + MEM[6];
assign MEM[51] = MEM[8] + MEM[15];
assign MEM[52] = MEM[9] + MEM[17];
assign MEM[53] = MEM[16] + MEM[23];
assign MEM[54] = MEM[29] + MEM[42];
assign MEM[55] = MEM[30] + MEM[37];
assign MEM[56] = MEM[39] + MEM[41];
assign MEM[57] = MEM[44] + MEM[49];
assign MEM[58] = MEM[1] + MEM[3];
assign MEM[59] = MEM[2] + MEM[11];
assign MEM[60] = MEM[5] + MEM[7];
assign MEM[61] = MEM[12] + MEM[19];
assign MEM[62] = MEM[14] + MEM[20];
assign MEM[63] = MEM[21] + MEM[26];
assign MEM[64] = MEM[24] + MEM[25];
assign MEM[65] = MEM[31] + MEM[40];
assign MEM[66] = MEM[33] + MEM[36];
assign MEM[67] = MEM[38] + MEM[45];
assign MEM[68] = MEM[46] + MEM[47];
assign MEM[69] = MEM[49] + MEM[51];
assign MEM[70] = MEM[50] + MEM[51];
assign MEM[71] = MEM[50] + MEM[52];
assign MEM[72] = MEM[52] + MEM[53];
assign MEM[73] = MEM[53] + MEM[54];
assign MEM[74] = MEM[54] + MEM[55];
assign MEM[75] = MEM[55] + MEM[56];
assign MEM[76] = MEM[56] + MEM[57];
assign MEM[77] = MEM[57] + MEM[62];
assign MEM[78] = MEM[58] + MEM[60];
assign MEM[79] = MEM[59] + MEM[61];
assign MEM[80] = MEM[63] + MEM[67];
assign MEM[81] = MEM[64] + MEM[65];
assign MEM[82] = MEM[66] + MEM[70];
assign MEM[83] = MEM[68] + MEM[69];
assign MEM[84] = MEM[71] + MEM[74];
assign MEM[85] = MEM[72] + MEM[75];
assign MEM[86] = MEM[73] + MEM[78];
assign MEM[87] = MEM[76] + MEM[79];
assign MEM[88] = MEM[77] + MEM[82];
assign MEM[89] = MEM[80] + MEM[83];
assign MEM[90] = MEM[81] + MEM[84];
assign MEM[91] = MEM[85] + MEM[88];
assign MEM[92] = MEM[86] + MEM[89];
assign MEM[93] = MEM[87] + MEM[90];
assign output_vector[0] = MEM[91];
assign output_vector[1] = MEM[92];
assign output_vector[2] = MEM[93];

endmodule
