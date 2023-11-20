include "program_counter.v"
include "instruction_memory.v"

module Single_Cycle_Top (clk, rst);
  input clk, rst;

  wire [31:0] PC_Top;

  Program_Counter PC(
    .clk(clk),
    .rst(rst),
    .PC(PC_Top),
    .PC_NEXT()
  );

endmodule
