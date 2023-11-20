module Instruction_Memory(A, rst, Rd);
  input [31:0] A;
  input rst;
  output [31:0] Rd;

  reg [31:0] Memory [1023:0];

  assign Rd = (rst == 1'b0) ? 32'h00000000 : Memory[A[31:2]];
endmodule
