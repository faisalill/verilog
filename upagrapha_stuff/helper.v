function void fill_zeroes (input integer rows, input integer cols, output reg [31:0] array [0:rows-1][0:cols-1]);

    for (integer i = 0; i < rows; i = i + 1) begin
        for (integer j = 0; j < cols; j = j + 1) begin
            array[i][j] <= 32'b0;  // Assign zero to each element
        end
    end

endfunction

function void fill_random_one_or_zero (input integer rows, input integer cols, output reg [31:0] array [0:rows-1][0:cols-1]);
  integer i,j;
  reg random_bit;  

  for (i = 0; i < rows; i = i + 1) begin
      for (j = 0; j < cols; j = j + 1) begin
        // Generate a random bit (0 or 1)
        random_bit = $random % 2;

        // Assign the random bit to the array element
        array[i][j] = random_bit;
      end
    end

endfunction
