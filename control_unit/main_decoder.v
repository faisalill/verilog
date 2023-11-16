module Main_Decoder(zero, ResultSrc, MemWrite, AluSrc, ImmSrc, RegWrite, op, AluOp, PcSrc, Branch)

  input zero;
  input [6:0] op;

  output [1:0] ImmSrc, AluOp;
  output ResultSrc, MemWrite, AluSrc, RegWrite, Branch, PcSrc;
  
  wire branch;

  assign RegWrite = (op == 7'b0000011) ? 1'b1 : 
                    (op == 7'b0100011) ? 1'b0 :
                    (op == 7'b0110011) ? 1'b1 :
                    1'b0;

  assign ImmSrc = (op == 7'b0000011) ? 2'b00 :
                  (op == 7'b0100011) ? 2'b01 :
                  (op == 7'b0110011) ? 2'b00 :
                  2'b00;

  assign AluSrc = (op == 7'b0000011) ? 1'b1 :
                  (op == 7'b0100011) ? 1'b1 :
                  (op == 7'b0110011) ? 1'b0 :
                  1'b0;
  
  assign MemWrite = (op == 7'b0000011) ? 1'b0 :
                    (op == 7'b0100011) ? 1'b1 :
                    (op == 7'b0110011) ? 1'b0 :
                    1'b0;                
  
  assign ResultSrc = (op == 7'b0000011) ? 1'b1 : 
                     (op == 7'b0100011) ? 1'b0 :
                     (op == 7'b0110011) ? 1'b0 :
                     1'b0;
  
  assign Branch = (op == 7'b1100011) ? 1'b1 : 1'b0;

  assign AluOp = (op == 7'b0110011) ? 2'b10 :
                 (op == 7'b1100011) ? 2'b01 :
                 2'b00;
  
  assign PcSrc = zero & branch;
endmodule




