
    module matrix_mult_single_bit
        #(
        parameter input_bit_width = 1,
        parameter output_bit_width = 32
        )
        (
        input input0,
        input input1,
        input input2,
        output [output_bit_width-1:0] output0,
        output [output_bit_width-1:0] output1,
        output [output_bit_width-1:0] output2
        );
        // Matrix A
        wire [31:0] A00;
        assign A00 = (input0==1'b1) ? 32'b00000000000000000000101011000011:32'b11111111111111111111010100111101;
        wire [31:0] A01;
        assign A01 = (input1==1'b1) ? 32'b11111111111111111100100100001010:32'b00000000000000000011011011110110;
        wire [31:0] A02;
        assign A02 = (input2==1'b1) ? 32'b11111111111111111110110101001000:32'b00000000000000000001001010111000;
        wire [31:0] A10;
        assign A10 = (input0==1'b1) ? 32'b00000000000000000101010110000001:32'b11111111111111111010101001111111;
        wire [31:0] A11;
        assign A11 = (input1==1'b1) ? 32'b11111111111111111000010100101100:32'b00000000000000000111101011010100;
        wire [31:0] A12;
        assign A12 = (input2==1'b1) ? 32'b11111111111111111010001000100111:32'b00000000000000000101110111011001;
        wire [31:0] A20;
        assign A20 = (input0==1'b1) ? 32'b00000000000000000010101001011000:32'b11111111111111111101010110101000;
        wire [31:0] A21;
        assign A21 = (input1==1'b1) ? 32'b00000000000000000101000011001111:32'b11111111111111111010111100110001;
        wire [31:0] A22;
        assign A22 = (input2==1'b1) ? 32'b11111111111111111010010111101000:32'b00000000000000000101101000011000;
        
        // Output_list
        assign output0 = A00 + A01 + A02;
        assign output1 = A10 + A11 + A12;
        assign output2 = A20 + A21 + A22;

    endmodule
    