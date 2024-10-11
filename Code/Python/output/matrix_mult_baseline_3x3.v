
    module matrix_mult
        #(
        parameter input_bit_width = 2,
        parameter output_bit_width = 16
        )
        (
        input [input_bit_width-1:0] B0,
        input [input_bit_width-1:0] B1,
        input [input_bit_width-1:0] B2,
        output [output_bit_width-1:0] C0,
        output [output_bit_width-1:0] C1,
        output [output_bit_width-1:0] C2
        );

        // Matrix A
        wire [16:0] A00 = 16'd2755;
        wire [16:0] A01 = 16'd51466;
        wire [16:0] A02 = 16'd60744;
        wire [16:0] A10 = 16'd21889;
        wire [16:0] A11 = 16'd34092;
        wire [16:0] A12 = 16'd41511;
        wire [16:0] A20 = 16'd10840;
        wire [16:0] A21 = 16'd20687;
        wire [16:0] A22 = 16'd42472;

        // Shift and add modules
        shift_and_add #(WIDTH) mult00 (.A(A00), .B(B0), .P(P00));
        shift_and_add #(WIDTH) mult01 (.A(A01), .B(B1), .P(P01));
        shift_and_add #(WIDTH) mult02 (.A(A02), .B(B2), .P(P02));
        assign C0 = P00 + P01 + P02;
        shift_and_add #(WIDTH) mult10 (.A(A10), .B(B0), .P(P10));
        shift_and_add #(WIDTH) mult11 (.A(A11), .B(B1), .P(P11));
        shift_and_add #(WIDTH) mult12 (.A(A12), .B(B2), .P(P12));
        assign C1 = P10 + P11 + P12;
        shift_and_add #(WIDTH) mult20 (.A(A20), .B(B0), .P(P20));
        shift_and_add #(WIDTH) mult21 (.A(A21), .B(B1), .P(P21));
        shift_and_add #(WIDTH) mult22 (.A(A22), .B(B2), .P(P22));
        assign C2 = P20 + P21 + P22;

    endmodule
    