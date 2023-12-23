include "helper.v"

reg [31:0] ASM = 32'h1ACFFC1D;
reg [31:0] FH = 32'hFFEEDD;
reg [31:0] FH1 = 32'hFFEEDD00;
reg [31:0] FH2 = 32'hFFEEDD01;
reg [31:0] FH3 h= 32'hFFEEDD02;
reg [31:0] FH4 = 32'hFFEEDD03;
reg [31:0] FH5 = 32'hFFEEDD04;
reg [31:0] FH6 = 32'hFFEEDD05;
reg [31:0] FH7 = 32'hFFEEDD06;
reg [31:0] FH8 = 32'hFFEEDD07;

reg [31:0] x [0:1151] [0:5];
fill_zeroes(1152, 6, x);
reg [31:0] txCRC [0:1167] [0:5];
fill_zeroes(1168, 6 ,txCRC);
reg [31:0] crcCodeword [0:5] [0:1167];
fill_zeroes(6, 1168, crcCodeword);
reg [31:0] rxMajorFrame [0:5] [0:1151];
fill_zeroes(6, 1152, rxMajorFrame);
reg [31:0] y [0:1151] [0:5];
fill_zeroes(1152, 6, y);
reg [31:0] rxCRC [0:1167] [0:5];
fill_zeroes(1168, 6, rxCRC);
reg [31:0] rxCrcCodeword [0:5] [0:1167];
fill_zeroes(6, 1168, rxCrcCodeword);
reg [31:0] crcCompare [0:0] [0:5];
fill_zeroes(1, 6, crcCompare);
reg [31:0] SNR = 32'd4; 
reg [31:0] match [0:0] [0:5];
fill_zeroes(1, 6, match);
reg [31:0] mismatch [0:0] [0:5];
fill_zeroes(1, 6, mismatch);

reg [31:0] totalmatch = 32'd0;
reg [31:0] totalmismatch = 32'd0;
reg [31:0] cycleBER = 32'd0;
reg [31:0] xGyroRx [0:5] [0:127];
fill_zeroes(6, 128, xGyroRx);
reg [31:0] yGyroRx [0:5] [0:127];
fill_zeroes(6, 128, yGyroRx);
reg [31:0] zGyroRx [0:5] [0:127];
fill_zeroes(6, 128, zGyroRx);
reg [31:0] q1Rx [0:5] [0:63];
fill_zeroes(6, 64, q1Rx);
reg [31:0] q2Rx [0:5] [0:63];
fill_zeroes(6, 64, q2Rx);
reg [31:0] q3Rx [0:5] [0:63];
fill_zeroes(6, 64, q3Rx);
reg [31:0] q4Rx [0:5] [0:63];
fill_zeroes(6, 64, q4Rx);
reg [31:0] lastCmdRx [0:5] [0:255];
fill_zeroes(6, 256, lastCmdRx);
reg [31:0] tmNoOfErrors = 32'd0;
reg [31:0] iiloop = 32'd100;
reg [31:0] tmSuccessfullyReceivedBits [0:0] [0:iiloop];
fill_zeroes(1, iiloop+1, tmSuccessfullyReceivedBits);
reg [31:0] tmUnsuccessfullyReceivedBits [0:0] [0:iiloop];
fill_zeroes(1, iiloop+1, tmUnsuccessfullyReceivedBits);
reg [31:0] tmTransmittedbits [0:0] [0:iiloop];
fill_zeroes(1, iiloop+1, tmTransmittedbits);

reg [31:0] xGyro [0:5] [0:127];
reg [31:0] yGyro [0:5] [0:127];
reg [31:0] zGyro [0:5] [0:127];
reg [31:0] q1 [0:5] [0:63];
reg [31:0] q2 [0:5] [0:63];
reg [31:0] q3 [0:5] [0:63];
reg [31:0] q4 [0:5] [0:63];
reg [31:0] lastCmd [0:5] [0:255];

reg [31:0] ii; 
reg random_bit ;
for (ii = 0; ii < iiloop; ii = ii + 1) begin
  fill_random_one_or_zero(6, 128, xGyro); 
  fill_random_one_or_zero(6, 128, yGyro);
  fill_random_one_or_zero(6, 128, zGyro);
  fill_random_one_or_zero(6, 64, q1);
  fill_random_one_or_zero(6, 64, q2);
  fill_random_one_or_zero(6, 64, q3);
  fill_random_one_or_zero(6, 64, q4);
  fill_random_one_or_zero(6, 256, lastCmd);
end
  
