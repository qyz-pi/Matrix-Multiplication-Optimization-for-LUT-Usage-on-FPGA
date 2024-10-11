
    module matrix_mult
        #(
        parameter input_bit_width = 4,
        parameter output_bit_width = 16
        )
        (
        input wire [input_bit_width-1:0] B0,
        input wire [input_bit_width-1:0] B1,
        input wire [input_bit_width-1:0] B2,
        output wire [output_bit_width-1:0] C0,
        output wire [output_bit_width-1:0] C1,
        output wire [output_bit_width-1:0] C2
        );

        // Matrix A
        wire [15:0] A00 = 16'd2755;
        wire [15:0] A01 = 16'd51466;
        wire [15:0] A02 = 16'd60744;
        wire [15:0] A10 = 16'd21889;
        wire [15:0] A11 = 16'd34092;
        wire [15:0] A12 = 16'd41511;
        wire [15:0] A20 = 16'd10840;
        wire [15:0] A21 = 16'd20687;
        wire [15:0] A22 = 16'd42472;

        // Matrix multiplication
        assign C0 = A00*B0 + A01*B1 + A02*B2;
        assign C1 = A10*B0 + A11*B1 + A12*B2;
        assign C2 = A20*B0 + A21*B1 + A22*B2;

    endmodule
    