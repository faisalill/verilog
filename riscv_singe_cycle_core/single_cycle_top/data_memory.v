module Data_Memory(clk, A, WD, WE, RD);

  input clk; 
  input [31:0] A, WD;
  input WE;

  output [31:0] RD;
  
  reg [31:0] Memory [1023:0]; 

  assign RD = (WE == 1'b0) ? Memory[A] : 32'h00000000; 
  
  always @(posedge clk) begin 
    if (WE) begin 
        Memory[A] <= WD;
      end 
  end
endmodule
