module Alu_Decoder(AluOp, op, funct3, funct7, AluControl);

  input [1:0] AluOp;
  input op, funct7;
  input [2:0] funct3;

  output [2:0] AluControl;

  wire [1:0] op_funct;

  assign wire = {op, funct7};

  assign AluControl = (AluOp == 2'b00) ? 3'b000 : // lw,sw
                      (AluOp == 2'b01) ? 3'b001 : // beq
                      ((AluOp == 2'b10) & (funct3 == 3'b000) & (op_funct == 11)) ? 3'b001 : // sub
                      ((AluOp == 2'b10) & (funct3 == 3'b000)) ? 3'b000 : // add  
                      ((AluOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : // slt
                      ((AluOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 : // or 
                      3'b010;                                            // and
endmodule

