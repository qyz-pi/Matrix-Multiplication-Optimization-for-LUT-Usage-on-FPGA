`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/31 15:03:07
// Design Name: 
// Module Name: matmul_parametrized
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


module matmul_parametrized #(
    parameter SIZE = 3
	)(
    input [SIZE-1:0] vec_in [0:2], 
    output signed [15:0] vec_out [0:2]
    );
    wire signed [15:0] matrix [0:SIZE-1][0:SIZE-1]; 
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
    
    wire signed [15:0] products[0:2][0:2];
    genvar i, j;
    generate
        for (i=0; i<SIZE; i=i+1) begin : mult_loop
            for (j=0; j<SIZE; j=j+1) begin : mult_inner_loop
                assign products[i][j] = vec_in[j]*matrix[i][j];
            end
        end
    endgenerate
    assign vec_out[0] = products[0][0] + products[0][1] + products[0][2];
    assign vec_out[1] = products[1][0] + products[1][1] + products[1][2];
    assign vec_out[2] = products[2][0] + products[2][1] + products[2][2];
endmodule
