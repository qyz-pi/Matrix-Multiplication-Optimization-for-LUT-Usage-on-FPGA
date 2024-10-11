`timescale 1ns / 1ns
(* DONT_TOUCH = "true" *)
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/16 05:10:10
// Design Name: 
// Module Name: shift_and_add
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


module shift_and_add #(parameter WIDTH=16)
(
    input [WIDTH-1:0] A,
    input [2:0] B,
    output [WIDTH-1:0] P
);

    wire [WIDTH-1:0] shift_0 = (B[0]) ? A : 0;
    wire [WIDTH-1:0] shift_1 = (B[1]) ? (A << 1) : 0;
    wire [WIDTH-1:0] shift_2 = (B[2]) ? (A << 2) : 0;
    //wire [WIDTH-1:0] shift_3 = (B[3]) ? (A << 3) : 0;
    /*wire [WIDTH-1:0] shift_4 = (B[4]) ? (A << 4) : 0;
    wire [WIDTH-1:0] shift_5 = (B[5]) ? (A << 5) : 0;
    wire [WIDTH-1:0] shift_6 = (B[6]) ? (A << 6) : 0;
    wire [WIDTH-1:0] shift_7 = (B[7]) ? (A << 7) : 0;
    wire [WIDTH-1:0] shift_8 = (B[8]) ? (A << 8) : 0;
    wire [WIDTH-1:0] shift_9 = (B[9]) ? (A << 9) : 0;
    wire [WIDTH-1:0] shift_10 = (B[10]) ? (A << 10) : 0;
    wire [WIDTH-1:0] shift_11 = (B[11]) ? (A << 11) : 0;
    wire [WIDTH-1:0] shift_12 = (B[12]) ? (A << 12) : 0;
    wire [WIDTH-1:0] shift_13 = (B[13]) ? (A << 13) : 0;
    wire [WIDTH-1:0] shift_14 = (B[14]) ? (A << 14) : 0;
    wire [WIDTH-1:0] shift_15 = (B[15]) ? (A << 15) : 0;*/
    assign P = shift_0 + shift_1 + shift_2;
    //assign P = shift_0 + shift_1 + shift_2 + shift_3 + shift_4 + shift_5 + shift_6 + shift_7 + shift_8 + shift_9 + shift_10 + shift_11 + shift_12 + shift_13 + shift_14 + shift_15;
endmodule

