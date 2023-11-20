module alu(A, B, Alu_Control, Result);
    
    // Inputs 
    input [31:0] A;
    input [31:0] B;

    // Control 
    input [2:0] Alu_Control;

    // Outputs
    output [31:0] Result;

    // Wires
    wire [31:0] and_a_b;
    wire [31:0] or_a_b;
    wire [31:0] not_b;
    wire [31:0] mux;
    wire [31:0] sum;
    
    // Assign Wires
    assign and_a_b = A & B;
    assign or_a_b = A | B;
    assign not_b = ~B;
    assign mux = (Alu_Control[0] == 1'b0) ? B : not_b;
    assign sum = A + mux + Alu_Control[0];
    assign Result = (Alu_Control[1:0] == 2'b00) ? sum : 
                        (Alu_Control[1:0] == 2'b01) ? sum :
                        (Alu_Control[1:0] == 2'b10) ? and_a_b :
                        or_a_b;

