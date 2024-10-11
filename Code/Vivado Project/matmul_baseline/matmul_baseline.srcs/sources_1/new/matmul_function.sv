`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/31 14:44:22
// Design Name: 
// Module Name: matmul_function
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


module matmul_function(
    input [2:0] vec_in [0:2], 
    output [15:0] vec_out [0:2]
	);
    wire [15:0] matrix [0:2][0:2]; 
    // Assign values to matrix elements here
    function [15:0] multiply_add;
        input [2:0] vec;
        input [15:0] mat_row [0:2];
        integer i;
        begin
            multiply_add = 0;
            for (i=0; i<3; i=i+1)
                multiply_add = multiply_add + vec[i]*mat_row[i];
        end
    endfunction

    assign vec_out[0] = multiply_add(vec_in, matrix[0]);
    assign vec_out[1] = multiply_add(vec_in, matrix[1]);
    assign vec_out[2] = multiply_add(vec_in, matrix[2]);
endmodule