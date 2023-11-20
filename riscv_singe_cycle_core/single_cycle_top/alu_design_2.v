module alu(A, B, Alu_Control, Result, N, Z, C, V);
    
    // Inputs 
    input [31:0] A;
    input [31:0] B;

    // Control 
    input [2:0] Alu_Control;

    // Outputs
    output [31:0] Result;
    output N, Z, C, V;
    
    // Wires
    wire [31:0] and_a_b;
    wire [31:0] or_a_b;
    wire [31:0] not_b;
    wire [31:0] mux_1;
    wire [31:0] sum;
    wire [31:0] mux_2; 
    wire cout;
    wire [31:0] Result;
    wire [31:0] set_less_than;

    // Assign Wires
    assign and_a_b = A & B;
    assign or_a_b = A | B;
    assign not_b = ~B;
    assign mux_1 = (Alu_Control[0] == 1'b0) ? B : not_b;
    assign {cout, sum} = A + mux_1 + Alu_Control[0];
    assign mux_2 = (Alu_Control[2:0] == 3'b000) ? sum : 
                   (Alu_Control[2:0] == 3'b001) ? sum :
                   (Alu_Control[2:0] == 3'b010) ? and_a_b :
                   (Alu_Control[2:0] == 3'b011) ? or_a_b :
                   (Alu_Control[2:0] == 3'b101) ? set_less_than :
                   32'h00000000;
 
    assign Result = mux_2;
    
    assign Z = &(~mux_2);) 

    assign N = mux_2[31];
    
    assign C = cout & (~Alu_Control[1]);
    
    assign V = (~Alu_Control[1]) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ Alu_Control[0]));

    assign set_less_than = {31'b0000000000000000000000000000000, sum[31]};

