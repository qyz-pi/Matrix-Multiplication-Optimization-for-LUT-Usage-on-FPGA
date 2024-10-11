`timescale 1ns / 1ns
module matrix_mult
        #(
        parameter input_bit_width = 3,
        parameter output_bit_width = 16,
        parameter WIDTH = 16
        )
        (
        input [input_bit_width-1:0] vec_in [0:2],
        output signed [output_bit_width-1:0] vec_out [0:2]
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

        // Shift and add module
        wire [WIDTH-1:0] P00;
        wire [WIDTH-1:0] P01;
        wire [WIDTH-1:0] P02;
        wire [WIDTH-1:0] P10;
        wire [WIDTH-1:0] P11;
        wire [WIDTH-1:0] P12;
        wire [WIDTH-1:0] P20;
        wire [WIDTH-1:0] P21;
        wire [WIDTH-1:0] P22;
        
        shift_and_add #(WIDTH) mult00 (.A(matrix[0][0]), .B(vec_in[0]), .P(P00));
        shift_and_add #(WIDTH) mult01 (.A(matrix[0][1]), .B(vec_in[1]), .P(P01));
        shift_and_add #(WIDTH) mult02 (.A(matrix[0][2]), .B(vec_in[2]), .P(P02));
        assign vec_out[0] = P00 + P01 + P02;
        shift_and_add #(WIDTH) mult10 (.A(matrix[1][0]), .B(vec_in[0]), .P(P10));
        shift_and_add #(WIDTH) mult11 (.A(matrix[1][1]), .B(vec_in[1]), .P(P11));
        shift_and_add #(WIDTH) mult12 (.A(matrix[1][2]), .B(vec_in[2]), .P(P12));
        assign vec_out[1] = P10 + P11 + P12;
        shift_and_add #(WIDTH) mult20 (.A(matrix[2][0]), .B(vec_in[0]), .P(P20));
        shift_and_add #(WIDTH) mult21 (.A(matrix[2][1]), .B(vec_in[1]), .P(P21));
        shift_and_add #(WIDTH) mult22 (.A(matrix[2][2]), .B(vec_in[2]), .P(P22));
        assign vec_out[2] = P20 + P21 + P22;

    endmodule    
    