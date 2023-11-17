module Register_File(clk, rst, A1, A2, A3, WD3, WE3, RD1, RD2);

  input clk, rst;
  input [4:0] A1, A2, A3;
  input [31:0] WD3;
  input WE3;

  output [31:0] RD1, RD2;

  reg [31:0] Memory [31:0];

  assign RD1 = (rst == 1'b0) ? 32'h00000000 : Memory[A1]; 

  assign RD2 = (rst == 1'b0) ? 32'h00000000 : Memory[A2];

  always @(posedge clk)
  begin 
  if (WE3) begin 
      Memory[A3] <= WD3;
    end 
  end

endmodule
