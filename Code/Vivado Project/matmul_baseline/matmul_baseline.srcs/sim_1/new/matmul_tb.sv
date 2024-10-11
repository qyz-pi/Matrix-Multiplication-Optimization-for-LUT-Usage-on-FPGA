`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/31 14:01:33
// Design Name: 
// Module Name: matmul_tb
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


module matmul_tb;
    reg [2:0] vec_in [0:2];
    reg [16:0] vec_out [0:2];
    parameter ROWS = 3;
    parameter COLS = 3;
    parameter MEM_SIZE = 93;
    parameter input_bit_width = 3;
    parameter output_bit_width = 16;
    parameter WIDTH = 16;
    initial begin
        vec_in[0] = 0;
        vec_in[1] = 0;    
        vec_in[2] = 1;
    end
// instantiate UUT
  /*  matmul_hardcoded uut (
        .vec_in(vec_in),
        .vec_out(vec_out)
    );*/
   /* 
    matmul_generate uut (
        .vec_in(vec_in),
        .vec_out(vec_out)
    );*/
  /*  matrix_multiplier #(
    .ROWS(ROWS),
    .COLS(COLS),
    .MEM_SIZE(MEM_SIZE),
    .input_bit_width(input_bit_width),
    .output_bit_width(output_bit_width)
) uut (
    .input_vector(vec_in),
    .output_vector(vec_out)
);*/
   /* matrix_mult #(
    .WIDTH(WIDTH)
    ) uut (
        .vec_in(vec_in),
        .vec_out(vec_out)
    );*/


  /*  matmul_parametrized uut (
        .vec_in(vec_in),
        .vec_out(vec_out)
    );*/
matrix_mult_single_bit uut (
.input0(vec_in[0]),
.input1(vec_in[1]),
.input2(vec_in[2]),
.output0(vec_out[0]),
.output1(vec_out[1]),
.output2(vec_out[2])
);
endmodule
