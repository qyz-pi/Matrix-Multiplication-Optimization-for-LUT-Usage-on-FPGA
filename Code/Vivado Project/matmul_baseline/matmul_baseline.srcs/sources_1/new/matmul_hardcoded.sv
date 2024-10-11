`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/31 13:57:26
// Design Name: 
// Module Name: matmul_hardcoded
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
module matmul_hardcoded(
    input [2:0] vec_in [0:2], 
    output signed [15:0] vec_out [0:2]
	);
    wire signed [15:0] matrix [0:2][0:2]; 
    // Assign values to matrix elements here
    assign matrix[0][0] = 2755;
    assign matrix[0][1] = -14070;
    assign matrix[0][2] = -4792;
    assign matrix[1][0] = 21889;
    assign matrix[1][1] = -31444;
    assign matrix[1][2] = -24025;
    assign matrix[2][0] = 10840;
    assign matrix[2][1] = 20687;
    assign matrix[2][2] = -23064;
    
    assign vec_out[0] = vec_in[0]*matrix[0][0] + vec_in[1]*matrix[0][1] + vec_in[2]*matrix[0][2];
    assign vec_out[1] = vec_in[0]*matrix[1][0] + vec_in[1]*matrix[1][1] + vec_in[2]*matrix[1][2];
    assign vec_out[2] = vec_in[0]*matrix[2][0] + vec_in[1]*matrix[2][1] + vec_in[2]*matrix[2][2];
endmodule