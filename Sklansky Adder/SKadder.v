`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2023 22:53:11
// Design Name: 
// Module Name: SKadder
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


module SKadder(clk,A,B,cin,sum,cout);

//-------------------------------------PORTS DECLARATION----------------------------------//
input clk,cin;
input [15:0] A,B;
output reg [15:0] sum,cout;

//-------------------------------------INTERMEDIATE SIGNALS DECLARATION----------------------------------//
wire [15:0]G0,P0;
wire [7:0] G1,P1,G2,P2,G3,P3,G4,P4;
reg [15:0]G0_1,P0_1,G0_2,P0_2,G0_3,P0_3,G0_4,P0_4,P0_5;
reg [7:0]G1_2,P1_2,G1_3,P1_3,G1_4,P1_4,G2_3,P2_3,G2_4,P2_4,G3_4,P3_4;
reg [15:0]c1,c2,c3,c4,c5;
reg cout1;

//-------------------------------------FIRST STAGE G's AND P's GENERATION----------------------------------//

assign G0[0] = (A[0] & B[0]) | (cin & (A[0] | B[0])),
       G0[1] = A[1] & B[1],
       G0[2] = A[2] & B[2],
       G0[3] = A[3] & B[3],
       G0[4] = A[4] & B[4],
       G0[5] = A[5] & B[5],
       G0[6] = A[6] & B[6],
       G0[7] = A[7] & B[7],
       G0[8] = A[8] & B[8],
       G0[9] = A[9] & B[9],
       G0[10] = A[10] & B[10],
       G0[11] = A[11] & B[11],
       G0[12] = A[12] & B[12],
       G0[13] = A[13] & B[13],
       G0[14] = A[14] & B[14],
       G0[15] = A[15] & B[15];
       
assign P0[0] = A[0] ^ B[0],
       P0[1] = A[1] ^ B[1],
       P0[2] = A[2] ^ B[2],
       P0[3] = A[3] ^ B[3],
       P0[4] = A[4] ^ B[4],
       P0[5] = A[5] ^ B[5],
       P0[6] = A[6] ^ B[6],
       P0[7] = A[7] ^ B[7],
       P0[8] = A[8] ^ B[8],
       P0[9] = A[9] ^ B[9],
       P0[10] = A[10] ^ B[10],
       P0[11] = A[11] ^ B[11],
       P0[12] = A[12] ^ B[12],
       P0[13] = A[13] ^ B[13],
       P0[14] = A[14] ^ B[14],
       P0[15] = A[15] ^ B[15];  
       
//-------------------------------------FIRST STAGE G's AND P's REGISTERING----------------------------------//

always@(posedge clk)
    begin
        c1[0] <= cin;
        c1[1] <= G0[0];
        G0_1 <= G0;
        P0_1 <= P0;
    end 
    
//-------------------------------------SECOND STAGE G's AND P's GENERATION----------------------------------//  
gp_gen i2_1(G0_1[1],G0_1[0],P0_1[1],P0_1[0],G1[0],P1[0]);
gp_gen i2_2(G0_1[3],G0_1[2],P0_1[3],P0_1[2],G1[1],P1[1]);  
gp_gen i2_3(G0_1[5],G0_1[4],P0_1[5],P0_1[4],G1[2],P1[2]);
gp_gen i2_4(G0_1[7],G0_1[6],P0_1[7],P0_1[6],G1[3],P1[3]);
gp_gen i2_5(G0_1[9],G0_1[8],P0_1[9],P0_1[8],G1[4],P1[4]);
gp_gen i2_6(G0_1[11],G0_1[10],P0_1[11],P0_1[10],G1[5],P1[5]);
gp_gen i2_7(G0_1[13],G0_1[12],P0_1[13],P0_1[12],G1[6],P1[6]);
gp_gen i2_8(G0_1[15],G0_1[14],P0_1[15],P0_1[14],G1[7],P1[7]);    

//-------------------------------------SECOND STAGE G's AND P's REGISTERING----------------------------------// 
always@(posedge clk)
    begin
        c2[0] <= c1[0];
        c2[1] <= c1[1];
        c2[2] <= G1[0];
        G0_2 <= G0_1;
        P0_2 <= P0_1;
        G1_2 <= G1;
        P1_2 <= P1;
    end
    
//-------------------------------------THIRD STAGE G's AND P's GENERATION----------------------------------//    
gp_gen i3_1(G0_2[2],G1_2[0],P0_2[2],P1_2[0],G2[0],P2[0]);
gp_gen i3_2(G1_2[1],G1_2[0],P1_2[1],P1_2[0],G2[1],P2[1]);  
gp_gen i3_3(G0_2[6],G1_2[2],P0_2[6],P1_2[2],G2[2],P2[2]);
gp_gen i3_4(G1_2[3],G1_2[2],P1_2[3],P1_2[2],G2[3],P2[3]);
gp_gen i3_5(G0_2[10],G1_2[4],P0_2[10],P1_2[4],G2[4],P2[4]);
gp_gen i3_6(G1_2[5],G1_2[4],P1_2[5],P1_2[4],G2[5],P2[5]);
gp_gen i3_7(G0_2[14],G1_2[6],P0_2[14],P1_2[6],G2[6],P2[6]);
gp_gen i3_8(G1_2[7],G1_2[6],P1_2[7],P1_2[6],G2[7],P2[7]);

//-------------------------------------THIRD STAGE G's AND P's REGISTERING----------------------------------// 
always@(posedge clk)
    begin
        c3[0] <= c2[0];
        c3[1] <= c2[1];
        c3[2] <= c2[2];
        c3[3] <= G2[0];
        c3[4] <= G2[1];
        G0_3 <= G0_2;
        P0_3 <= P0_2;
        G1_3 <= G1_2;
        P1_3 <= P1_2;
        G2_3 <= G2;
        P2_3 <= P2;
    end

//-------------------------------------FOURTH STAGE G's AND P's GENERATION----------------------------------//   
gp_gen i4_1(G0_3[4],G2_3[1],P0_3[4],P2_3[1],G3[0],P3[0]);
gp_gen i4_2(G1_3[2],G2_3[1],P1_3[2],P2_3[1],G3[1],P3[1]);  
gp_gen i4_3(G2_3[2],G2_3[1],P2_3[2],P2_3[1],G3[2],P3[2]);
gp_gen i4_4(G2_3[3],G2_3[1],P2_3[3],P2_3[1],G3[3],P3[3]);
gp_gen i4_5(G0_3[12],G2_3[5],P0_3[12],P2_3[5],G3[4],P3[4]);
gp_gen i4_6(G1_3[6],G2_3[5],P1_3[6],P2_3[5],G3[5],P3[5]);
gp_gen i4_7(G2_3[6],G2_3[5],P2_3[6],P2_3[5],G3[6],P3[6]);
gp_gen i4_8(G2_3[7],G2_3[5],P2_3[7],P2_3[5],G3[7],P3[7]);
   
//-------------------------------------FOURTH STAGE G's AND P's REGISTERING----------------------------------// 
always@(posedge clk)
    begin
        c4[0] <= c3[0];
        c4[1] <= c3[1];
        c4[2] <= c3[2];
        c4[3] <= c3[3];
        c4[4] <= c3[4];
        c4[5] <= G3[0];
        c4[6] <= G3[1];
        c4[7] <= G3[2];
        c4[8] <= G3[3];
        G0_4 <= G0_3;
        P0_4 <= P0_3;
        G1_4 <= G1_3;
        P1_4 <= P1_3;
        G2_4 <= G2_3;
        P2_4 <= P2_3;
        G3_4 <= G3;
        P3_4 <= P3;
    end   
    
//-------------------------------------FIFTH STAGE G's AND P's GENERATION----------------------------------//   
gp_gen i5_1(G0_4[8],G3_4[3],P0_4[8],P3_4[3],G4[0],P4[0]);
gp_gen i5_2(G1_4[4],G3_4[3],P1_4[4],P3_4[3],G4[1],P4[1]);  
gp_gen i5_3(G2_4[4],G3_4[3],P2_4[4],P3_4[3],G4[2],P4[2]);
gp_gen i5_4(G2_4[5],G3_4[3],P2_4[5],P3_4[3],G4[3],P4[3]);
gp_gen i5_5(G3_4[4],G3_4[3],P3_4[4],P3_4[3],G4[4],P4[4]);
gp_gen i5_6(G3_4[5],G3_4[3],P3_4[5],P3_4[3],G4[5],P4[5]);
gp_gen i5_7(G3_4[6],G3_4[3],P3_4[6],P3_4[3],G4[6],P4[6]);
gp_gen i5_8(G3_4[7],G3_4[3],P3_4[7],P3_4[3],G4[7],P4[7]);

//-------------------------------------FIFTH STAGE G's AND P's REGISTERING----------------------------------// 
always@(posedge clk)
    begin
        c5[0] <= c4[0];
        c5[1] <= c4[1];
        c5[2] <= c4[2];
        c5[3] <= c4[3];
        c5[4] <= c4[4];
        c5[5] <= c4[5];
        c5[6] <= c4[6];
        c5[7] <= c4[7];
        c5[8] <= c4[8];
        c5[9] <= G4[0];
        c5[10] <= G4[1];
        c5[11] <= G4[2];
        c5[12] <= G4[3];
        c5[13] <= G4[4];
        c5[14] <= G4[5];
        c5[15] <= G4[6];
        cout1 <= G4[7];
        P0_5 <= P0_4;
    end
//-------------------------------------SUM CALCULATION----------------------------------// 
always@(posedge clk)
    begin
        sum <= c5 ^ P0_5;
        cout <= cout1;
    end 
endmodule
