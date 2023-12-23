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
  
wire [143:0] minorFrame11, minorFrame12, minorFrame13, minorFrame14, minorFrame15, minorFrame16, minorFrame17, minorFrame18;

assign minorFrame11 = {FH1, xGyro[0][15:0], yGyro[0][15:0], zGyro[0][15:0], q1[0][15:0], q2[0][15:0], q3[0][15:0], q4[0][15:0], lastCmd[0][15:0]};

assign minorFrame12 = {FH2, xGyro[0][31:16], yGyro[0][31:16], zGyro[0][31:16], q1[0][31:16], q2[0][31:16], q3[0][31:16], q4[0][31:16], lastCmd[0][31:16]};

assign minorFrame13 = {FH3, xGyro[0][47:32], yGyro[0][47:32], zGyro[0][47:32], q1[0][47:32], q2[0][47:32], q3[0][47:32], q4[0][47:32], lastCmd[0][47:32]};

assign minorFrame14 = {FH4, xGyro[0][63:48], yGyro[0][63:48], zGyro[0][63:48], q1[0][63:48], q2[0][63:48], q3[0][63:48], q4[0][63:48], lastCmd[0][63:48]};

assign minorFrame15 = {FH5, xGyro[0][79:64], yGyro[0][79:64], zGyro[0][79:64], q1[0][79:64], q2[0][79:64], q3[0][79:64], q4[0][79:64], lastCmd[0][79:64]};

assign minorFrame16 = {FH6, xGyro[0][95:80], yGyro[0][95:80], zGyro[0][95:80], q1[0][95:80], q2[0][95:80], q3[0][95:80], q4[0][95:80], lastCmd[0][95:80]};

assign minorFrame17 = {FH7, xGyro[0][111:96], yGyro[0][111:96], zGyro[0][111:96], q1[0][111:96], q2[0][111:96], q3[0][111:96], q4[0][111:96], lastCmd[0][111:96]};

assign minorFrame18 = {FH8, xGyro[0][127:112], yGyro[0][127:112], zGyro[0][127:112], q1[0][127:112], q2[0][127:112], q3[0][127:112], q4[0][127:112], lastCmd[0][127:112]};

wire [143:0] minorFrame21, minorFrame22, minorFrame23, minorFrame24, minorFrame25, minorFrame26, minorFrame27, minorFrame28;

assign minorFrame21 = {FH1, xGyro[1][15:0], yGyro[1][15:0], zGyro[1][15:0], q1[1][15:0], q2[1][15:0], q3[1][15:0], q4[1][15:0], lastCmd[1][15:0]};

assign minorFrame22 = {FH2, xGyro[1][31:16], yGyro[1][31:16], zGyro[1][31:16], q1[1][31:16], q2[1][31:16], q3[1][31:16], q4[1][31:16], lastCmd[1][31:16]};

assign minorFrame23 = {FH3, xGyro[1][47:32], yGyro[1][47:32], zGyro[1][47:32], q1[1][47:32], q2[1][47:32], q3[1][47:32], q4[1][47:32], lastCmd[1][47:32]};

assign minorFrame24 = {FH4, xGyro[1][63:48], yGyro[1][63:48], zGyro[1][63:48], q1[1][63:48], q2[1][63:48], q3[1][63:48], q4[1][63:48], lastCmd[1][63:48]};

assign minorFrame25 = {FH5, xGyro[1][79:64], yGyro[1][79:64], zGyro[1][79:64], q1[1][79:64], q2[1][79:64], q3[1][79:64], q4[1][79:64], lastCmd[1][79:64]};

assign minorFrame26 = {FH6, xGyro[1][95:80], yGyro[1][95:80], zGyro[1][95:80], q1[1][95:80], q2[1][95:80], q3[1][95:80], q4[1][95:80], lastCmd[1][95:80]};

assign minorFrame27 = {FH7, xGyro[1][111:96], yGyro[1][111:96], zGyro[1][111:96], q1[1][111:96], q2[1][111:96], q3[1][111:96], q4[1][111:96], lastCmd[1][111:96]};

assign minorFrame28 = {FH8, xGyro[1][127:112], yGyro[1][127:112], zGyro[1][127:112], q1[1][127:112], q2[1][127:112], q3[1][127:112], q4[1][127:112], lastCmd[1][127:112]};

wire [143:0] minorFrame31, minorFrame32, minorFrame33, minorFrame34, minorFrame35, minorFrame36, minorFrame37, minorFrame38;

assign minorFrame31 = {FH1, xGyro[2][15:0], yGyro[2][15:0], zGyro[2][15:0], q1[2][15:0], q2[2][15:0], q3[2][15:0], q4[2][15:0], lastCmd[2][15:0]};

assign minorFrame32 = {FH2, xGyro[2][31:16], yGyro[2][31:16], zGyro[2][31:16], q1[2][31:16], q2[2][31:16], q3[2][31:16], q4[2][31:16], lastCmd[2][31:16]};

assign minorFrame33 = {FH3, xGyro[2][47:32], yGyro[2][47:32], zGyro[2][47:32], q1[2][47:32], q2[2][47:32], q3[2][47:32], q4[2][47:32], lastCmd[2][47:32]};

assign minorFrame34 = {FH4, xGyro[2][63:48], yGyro[2][63:48], zGyro[2][63:48], q1[2][63:48], q2[2][63:48], q3[2][63:48], q4[2][63:48], lastCmd[2][63:48]};

assign minorFrame35 = {FH5, xGyro[2][79:64], yGyro[2][79:64], zGyro[2][79:64], q1[2][79:64], q2[2][79:64], q3[2][79:64], q4[2][79:64], lastCmd[2][79:64]};

assign minorFrame36 = {FH6, xGyro[2][95:80], yGyro[2][95:80], zGyro[2][95:80], q1[2][95:80], q2[2][95:80], q3[2][95:80], q4[2][95:80], lastCmd[2][95:80]};

assign minorFrame37 = {FH7, xGyro[2][111:96], yGyro[2][111:96], zGyro[2][111:96], q1[2][111:96], q2[2][111:96], q3[2][111:96], q4[2][111:96], lastCmd[2][111:96]};

assign minorFrame38 = {FH8, xGyro[2][127:112], yGyro[2][127:112], zGyro[2][127:112], q1[2][127:112], q2[2][127:112], q3[2][127:112], q4[2][127:112], lastCmd[2][127:112]};

wire [143:0] minorFrame41, minorFrame42, minorFrame43, minorFrame44, minorFrame45, minorFrame46, minorFrame47, minorFrame48;

assign minorFrame41 = {FH1, xGyro[3][15:0], yGyro[3][15:0], zGyro[3][15:0], q1[3][15:0], q2[3][15:0], q3[3][15:0], q4[3][15:0], lastCmd[3][15:0]};

assign minorFrame42 = {FH2, xGyro[3][31:16], yGyro[3][31:16], zGyro[3][31:16], q1[3][31:16], q2[3][31:16], q3[3][31:16], q4[3][31:16], lastCmd[3][31:16]};

assign minorFrame43 = {FH3, xGyro[3][47:32], yGyro[3][47:32], zGyro[3][47:32], q1[3][47:32], q2[3][47:32], q3[3][47:32], q4[3][47:32], lastCmd[3][47:32]};

assign minorFrame44 = {FH4, xGyro[3][63:48], yGyro[3][63:48], zGyro[3][63:48], q1[3][63:48], q2[3][63:48], q3[3][63:48], q4[3][63:48], lastCmd[3][63:48]};

assign minorFrame45 = {FH5, xGyro[3][79:64], yGyro[3][79:64], zGyro[3][79:64], q1[3][79:64], q2[3][79:64], q3[3][79:64], q4[3][79:64], lastCmd[3][79:64]};

assign minorFrame46 = {FH6, xGyro[3][95:80], yGyro[3][95:80], zGyro[3][95:80], q1[3][95:80], q2[3][95:80], q3[3][95:80], q4[3][95:80], lastCmd[3][95:80]};

assign minorFrame47 = {FH7, xGyro[3][111:96], yGyro[3][111:96], zGyro[3][111:96], q1[3][111:96], q2[3][111:96], q3[3][111:96], q4[3][111:96], lastCmd[3][111:96]};

assign minorFrame48 = {FH8, xGyro[3][127:112], yGyro[3][127:112], zGyro[3][127:112], q1[3][127:112], q2[3][127:112], q3[3][127:112], q4[3][127:112], lastCmd[3][127:112]};

wire [143:0] minorFrame51, minorFrame52, minorFrame53, minorFrame54, minorFrame55, minorFrame56, minorFrame57, minorFrame58;

assign minorFrame51 = {FH1, xGyro[4][15:0], yGyro[4][15:0], zGyro[4][15:0], q1[4][15:0], q2[4][15:0], q3[4][15:0], q4[4][15:0], lastCmd[4][15:0]};

assign minorFrame52 = {FH2, xGyro[4][31:16], yGyro[4][31:16], zGyro[4][31:16], q1[4][31:16], q2[4][31:16], q3[4][31:16], q4[4][31:16], lastCmd[4][31:16]};

assign minorFrame53 = {FH3, xGyro[4][47:32], yGyro[4][47:32], zGyro[4][47:32], q1[4][47:32], q2[4][47:32], q3[4][47:32], q4[4][47:32], lastCmd[4][47:32]};

assign minorFrame54 = {FH4, xGyro[4][63:48], yGyro[4][63:48], zGyro[4][63:48], q1[4][63:48], q2[4][63:48], q3[4][63:48], q4[4][63:48], lastCmd[4][63:48]};

assign minorFrame55 = {FH5, xGyro[4][79:64], yGyro[4][79:64], zGyro[4][79:64], q1[4][79:64], q2[4][79:64], q3[4][79:64], q4[4][79:64], lastCmd[4][79:64]};

assign minorFrame56 = {FH6, xGyro[4][95:80], yGyro[4][95:80], zGyro[4][95:80], q1[4][95:80], q2[4][95:80], q3[4][95:80], q4[4][95:80], lastCmd[4][95:80]};

assign minorFrame57 = {FH7, xGyro[4][111:96], yGyro[4][111:96], zGyro[4][111:96], q1[4][111:96], q2[4][111:96], q3[4][111:96], q4[4][111:96], lastCmd[4][111:96]};

assign minorFrame58 = {FH8, xGyro[4][127:112], yGyro[4][127:112], zGyro[4][127:112], q1[4][127:112], q2[4][127:112], q3[4][127:112], q4[4][127:112], lastCmd[4][127:112]};

wire [143:0] minorFrame61, minorFrame62, minorFrame63, minorFrame64, minorFrame65, minorFrame66, minorFrame67, minorFrame68;

assign minorFrame61 = {FH1, xGyro[5][15:0], yGyro[5][15:0], zGyro[5][15:0], q1[5][15:0], q2[5][15:0], q3[5][15:0], q4[5][15:0], lastCmd[5][15:0]};

assign minorFrame62 = {FH2, xGyro[5][31:16], yGyro[5][31:16], zGyro[5][31:16], q1[5][31:16], q2[5][31:16], q3[5][31:16], q4[5][31:16], lastCmd[5][31:16]};

assign minorFrame63 = {FH3, xGyro[5][47:32], yGyro[5][47:32], zGyro[5][47:32], q1[5][47:32], q2[5][47:32], q3[5][47:32], q4[5][47:32], lastCmd[5][47:32]};

assign minorFrame64 = {FH4, xGyro[5][63:48], yGyro[5][63:48], zGyro[5][63:48], q1[5][63:48], q2[5][63:48], q3[5][63:48], q4[5][63:48], lastCmd[5][63:48]};

assign minorFrame65 = {FH5, xGyro[5][79:64], yGyro[5][79:64], zGyro[5][79:64], q1[5][79:64], q2[5][79:64], q3[5][79:64], q4[5][79:64], lastCmd[5][79:64]};

assign minorFrame66 = {FH6, xGyro[5][95:80], yGyro[5][95:80], zGyro[5][95:80], q1[5][95:80], q2[5][95:80], q3[5][95:80], q4[5][95:80], lastCmd[5][95:80]};

assign minorFrame67 = {FH7, xGyro[5][111:96], yGyro[5][111:96], zGyro[5][111:96], q1[5][111:96], q2[5][111:96], q3[5][111:96], q4[5][111:96], lastCmd[5][111:96]};

assign minorFrame68 = {FH8, xGyro[5][127:112], yGyro[5][127:112], zGyro[5][127:112], q1[5][127:112], q2[5][127:112], q3[5][127:112], q4[5][127:112], lastCmd[5][127:112]};

wire [1151:0] MajorFrame1, MajorFrame2, MajorFrame3, MajorFrame4, MajorFrame5, MajorFrame6;

assign MajorFrame1 = {minorFrame11, minorFrame12, minorFrame13, minorFrame14, minorFrame15, minorFrame16, minorFrame17, minorFrame18};

assign MajorFrame2 = {minorFrame21, minorFrame22, minorFrame23, minorFrame24, minorFrame25, minorFrame26, minorFrame27, minorFrame28};

assign MajorFrame3 = {minorFrame31, minorFrame32, minorFrame33, minorFrame34, minorFrame35, minorFrame36, minorFrame37, minorFrame38};

assign MajorFrame4 = {minorFrame41, minorFrame42, minorFrame43, minorFrame44, minorFrame45, minorFrame46, minorFrame47, minorFrame48};

assign MajorFrame5 = {minorFrame51, minorFrame52, minorFrame53, minorFrame54, minorFrame55, minorFrame56, minorFrame57, minorFrame58};

assign MajorFrame6 = {minorFrame61, minorFrame62, minorFrame63, minorFrame64, minorFrame65, minorFrame66, minorFrame67, minorFrame68};


