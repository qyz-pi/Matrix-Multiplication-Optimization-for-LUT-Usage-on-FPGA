## Report

The Methodology section offers an in-depth exposition of the principles and design strategies pertaining to all the algorithms and functionalities implemented. The Results and Discussion section elucidates the analysis and discourse on the outcomes of the comparative experiments. The Explanation for Uploaded Files section provides insights on how to comprehend and utilize the files uploaded.

## Methodology

This section presents a total of five approaches, including three matrix multiplication designs applicable to the Baseline, one optimized multiplication design, and one verification method for optimized multiplication.

### Baseline1: Matrix Multiplication (input with single bit value)

The approach first hardcodes the elements of matrix A. Each element has two possible values depending on whether the corresponding input bit is 1 or 0. For an input of 1, the element takes a positive value, and for an input of 0, it takes the two's complement representation of the negative value. This is achieved by a ternary operator that selects the value based on the input bit.

Subsequently, the approach computes the multiplication of the input vector with matrix A. Since each element of the input vector is single-bit (0 or 1), each row of matrix A is multiplied with the corresponding element of the input vector, and the results are added together.

```plaintext
Input: Single-bit input-vector input[COLS-1:0] 
Output: output[COLS-1:0]

Initialization: Hardcode matrix A (ROWS x COLS)

For i = 0 to COLS-1:
	For j = 0 to ROWS-1:
    	A[i][j] = (input[j] == 1) ? positive_value : two's_complement_negative_value

For i = 0 to COLS-1:
	For j = 0 to ROWS-1:
    	output[i] += A[i][j]
```

### Baseline2: Matrix Multiplication (hardcoded)

The approach first hardcodes a ROWS x COLS matrix. This matrix consists of ROWS x COLS signed 16-bit integer elements. Please notice that here we can parameterize the number of ROWS, COLS, and bit-size as we need.

Subsequently, the approach computes the multiplication of the input vector with the matrix. For each element of the output vector, it multiplies the corresponding elements of the input vector with the corresponding row of the matrix and adds the results together.

```
Input: [Input_bit_width-1:0] vec_in [COLS-1:0]
Output: [Output_bit_width-1:0] vec_out [COLS-1:0]

Initialization: Hardcode matrix A (ROWS x COLS)

For i = 0 to COLS-1:
	For j = 0 to ROWS-1:
    	vec_out[i] += vec_in[j] * matrix[i][j]
```

### Baseline3: Matrix Multiplication (shift and add)

The approach initially hardcodes a ROWS x COLS matrix.

Following this, the approach performs matrix multiplication using a shift-and-add method. This method is based on the fact that multiplication can be implemented using shifts and additions. Specifically, a submodule named `shift_and_add` is used, which takes two inputs A and B, and outputs the product of A and B.

Inside the `shift_and_add` module, A is left-shifted by the number of positions corresponding to each bit in B if that bit is 1, and then the results are summed. This approach leverages the fact that shift operations are more efficient than multiplication operations.

```
Input: [Input_bit_width-1:0] vec_in[COLS-1:0]
Output: [Output_bit_width-1:0] vec_out [COLS-1:0]

Initialization: Hardcode matrix A (ROWS x COLS)

For i = 0 to COLS-1:
    For j = 0 to ROWS-1:
        P[i][j] = shift_and_add(matrix[i][j], vec_in[j])
    vec_out[i] = Σ P[i][j] (j = 0 to ROWS-1)

Function shift_and_add(A, B):
    Initialize P = 0
    For k = 0 to (number of bits in B - 1):
        if B[k] is 1:
            P += A << k
    Return P
```

### Optimized Matrix Multiplication

This approach comprises two functions, `check_one_hot,` and `preprocess_matrix_to_array`, which process an input matrix and transform it into an array that stores necessary positions.

`check_one_hot`: This function checks if a matrix is in one-hot encoding, i.e., whether the sum of each row in the matrix is 1. It accomplishes this by summing up each row of the input matrix and checking if the sum is equal to 1.

`preprocess_matrix_to_array`: The primary objective of this function is to preprocess the input matrix into a binary matrix and to find the number of maximum matching ones. It then generates an array that stores the required left operand, right operand, target index, and the corresponding operation based on this information.

Below is a more detailed description:

1. **Initialization**: First, the algorithm computes the number of rows and columns from the shape of the input matrix. It also calculates the number of binary bits required for each element. Memory is allocated for the binary matrix, and an index array is initialized.
2. **Binary Conversion of Input Matrix**: The function iterates through each element in the input matrix, converting each element into its binary representation, and then storing the result in `bin_matrix`. This process is essential to carry out bitwise operations in the subsequent steps.
3. **Computing Maximum Matching**: The algorithm finds the maximum number of matching ones between the columns in the binary matrix. Matching ones are bits that are simultaneously 1 in the same row. This is achieved by iterating through all pairs of columns in the binary matrix.
4. **Processing Binary Matrix**: In this phase, the algorithm seeks matching ones and performs addition operations. It iterates through each column, examining matches with other columns, and performs a logical AND operation to find matching bits. These matching bits are then added to the input columns, and the result is stored in a new column. This process continues until a stopping condition is satisfied, either when the binary matrix becomes a one-hot encoding (checked by the `check_one_hot` function) or when the maximum number of matches is reached.
5. **Finding Output Indices**: The algorithm then identifies the rows which have columns with a value of 1 and records their positions.
6. **Building the Index Array**: This step aggregates all the results into an index array that contains information on how to transform from the input matrix to output indices. It stores the necessary left operand, right operand, target index, and corresponding operation.
7. **Returning Results**: Finally, the function returns the index array as output.

```
Function check_one_hot(matrix A):
    Return ∏(∑(A[i, j], for j=1 to n) == 1 for i=1 to m)

Function preprocess_matrix_to_array(matrix A):
    # Initialization
    m, n <- shape of A
    bit <- ⌈log₂(max(|A[i, j]|) + 1)⌉ + 1 for i=1 to m, j=1 to n
    bin_matrix <- zeros of shape (m, bit * n)
    index_array <- empty list
    
    # Binary Conversion of Input Matrix
    For i=1 to m:
        For j=1 to n:
            binary <- binary representation of A[i, j] with 'bit' bits
            bin_matrix[i, (j-1)*bit + 1 to j*bit] <- binary
            
    # Compute Maximum Matching
    max_matching <- 0
    For k=1 to bit * n:
        For l=k+1 to bit * n:
            matching <- ∑(bin_matrix[i, k] AND bin_matrix[i, l], for i=1 to m)
            max_matching <- max(max_matching, matching)
            
    # Process Binary Matrix
    cnt <- 0
    loop_range <- bit * n
    one_hot_met <- False
    
    While not one_hot_met:
        For k=1 to loop_range:
            For l=k+1 to loop_range:
                if ∑(bin_matrix[:, k]) >= one_count:
                    if ∑(bin_matrix[:, k] AND bin_matrix[:, l]) == one_count:
                        loop_range <- loop_range + 1
                        cnt <- cnt + 1
                        add_counts[m - one_count] <- add_counts[m - one_count] + 1 
                        # Append a new column with logical AND of columns k and l
                        bin_matrix <- horizontally concatenate (bin_matrix, zeros(m, 1))
                        bin_matrix[:, loop_range] <- bin_matrix[:, k] & bin_matrix[:, l]
                        # Update columns k and l
                        bin_matrix[:, k] <- bin_matrix[:, k] & ~bin_matrix[:, loop_range]
                        bin_matrix[:, l] <- bin_matrix[:, l] & ~bin_matrix[:, loop_range]    	
        if one_count > 1:
            one_count <- one_count - 1
        else:
            one_count <- 1
        # Check if one-hot condition is met to exit the while loop
        one_hot_met <- check_one_hot(bin_matrix)
    
    # Finding Output Indices
    output_indices <- list of indices (i, j) where bin_matrix[i, j] = 1 for i=1 to m
    
    # Building the Index Array
    index_array <- aggregation of calculated values
    
    # Printing and Returning Results
    Output bin_matrix and index_array
    Return index_array
```

### Matrix Optimized Multiplier

This approach optimizes the multiplication by processing the `index_array`, which contains information about the specific operations to perform on the `input_vector`. The `index_array` is an array of tuples in the format `[left_pos, right_pos, target#, 'operation']`, with the first row storing `[rows, cols, bit, 'parameters']`. The operations specified in the `index_array` include bitwise shifts and additions.

The main steps of the approach include:

a. Extracting the number of rows, columns, and the bit size from the index_array.

b. Initializing the output_vector to store the final results and the MEM array to store intermediate results.

c. Iterating through each row of the index_array, parsing the parameters, and performing specified operations:
    i. Left shift (`<<`): Multiplies the element of input_vector by 2^target# and stores it in MEM at left_pos.
    ii. Negated left shift (`-<<`): Negates and multiplies the element of input_vector by 2^target# and stores it in MEM at left_pos.
    iii. Addition (`+`): Adds the values in MEM at left_pos and right_pos and stores the sum in MEM at target#.
    
d. Populating the output_vector with the appropriate elements from the MEM array.

e. Returning the output_vector.

```
Function matrix_optimized_multiplier(index_array, input_vector):

    # Extract Parameters
    rows, cols <- index_array[0][0], index_array[0][1]
    bit <- index_array[0][2]
    mem_size <- length of index_array
    
    # Initialize Arrays
    Initialize output_vector of size (rows, 1) with zeros
    Initialize MEM of size (mem_size+1) with zeros
    
    # Perform Calculations
    counter <- 0
    For each row in index_array starting from the second row:
        if target# of row is not -1:
            if operation of row is '-<<':
                MEM[left_pos] <- -1 * 2^target# * input_vector[right_pos]
            elif operation of row is '>>':
                MEM[left_pos] <- 2^-target# * input_vector[right_pos]
            elif operation of row is '<<':
                MEM[left_pos] <- 2^target# * input_vector[right_pos]
            elif operation of row is '+':
                MEM[target#] <- MEM[left_pos] + MEM[right_pos]
        else:
            output_vector[counter] <- MEM[right_pos]
            increment counter by 1
            
    # Return the Output Vector
    Return output_vector
```



## Results and Discussion

This section aims to demonstrate that optimized matrix multiplication, compared to the baseline matrix multiplication, can save hardware resources, particularly in terms of Look-Up Table (LUT) utilization, at the hardware level. The conclusions presented in this section are derived from extensive comparative experiments conducted in the Vivado 2021.1 environment.

### Optimized VS Baseline (shift and add)

The specific data can be found on page 8 and page 9 of `pre_0516`.

![chart6](C:\Users\ZENG\Downloads\Project\Matrix-Multiplication-Optimization-for-LUT-Usage-on-FPGA\figure\chart6.png)


Please note that the Baseline referred to here is Baseline3: Matrix Multiplication (shift and add) method. The optimized approach demonstrates greater savings in terms of LUT resources compared to the Baseline method, and the advantage of savings increases with the increasing size of the matrices and the increasing input vector bit width.

In this comparison, we only consider input vector bit widths of 2, 4, 8, and 16, while keeping the matrix bit width fixed at 16. For more precise results, further comparative experiments would be required.

### Optimized VS Baseline (hardcoded)

The specific data can be found on page 5-7, page 9-11, and page 14-17 of `pre_0526`. 

Please note that the Baseline referred to here is Baseline2: Matrix Multiplication (hardcoded). In addition, for the Baseline2: Matrix Multiplication (hardcoded) approach, the synthesis strategy in this case is set with `max-dsp` as 0 to avoid the utilization of DSP resources.

![chart8](C:\Users\ZENG\Downloads\Project\Matrix-Multiplication-Optimization-for-LUT-Usage-on-FPGA\figure\chart8.png)

For a 3x3 16-bit matrix, the gap between the Baseline and Optimized methods increases as the input bit width increases. The Baseline method consumes more LUT resources.

![chart9](C:\Users\ZENG\Downloads\Project\Matrix-Multiplication-Optimization-for-LUT-Usage-on-FPGA\figure\chart9.png)

For an 8x8 16-bit matrix, the gap between the Baseline and Optimized methods increases as the input bit width increases. The Baseline method consumes more LUT resources.

![chart10](C:\Users\ZENG\Downloads\Project\Matrix-Multiplication-Optimization-for-LUT-Usage-on-FPGA\figure\chart10.png)

With the increase in Matrix size, the gap between Baseline and Optimized methods is increased. The Baseline method will use more LUT resources. The optimized method performs better optimization results in a larger size Matrix.

![chart11](C:\Users\ZENG\Downloads\Project\Matrix-Multiplication-Optimization-for-LUT-Usage-on-FPGA\figure\chart11.png)

The input bit width here is 4. When the Matrix bit width is less than 8, the two methods use considerable LUT resources. When the Matrix bit width is greater than 8, the Optimized method uses fewer resources.

For a single-bit input vector, the current optimization method does not achieve resource savings. Please refer to page 5 of `pre_0509` for the data.

## Explanation of Uploaded Files

This section is intended to aid in better understanding and application of the uploaded files.

### Matrix Multiplication Verilog Design Generation

The file is located in`./code/python`.

This file implements the optimized method and three Baseline methods to generate Verilog design code from an input matrix. 

It is worth mentioning that in the "Optimized matrix multiplication" section, both the `preprocess_matrix_to_array` and `minimize_operation_matrix` functions can generate an Index Array from a Matrix. The latter is an optimization of the former and requires an additional input parameter, `bit_size`. The optimization in the latter function helps save the time required for generating the Index Array. 

The optimization effect primarily stems from the following aspects: 1) Replacing the iterative computation of the maximum number of matching 1s between all columns with a simple computation of the maximum number of 1s among all columns; 2) Replacing the loop with a while condition check.

`output` folder is used to store all generated Verilog files.

### Matrix Multiplication Validation

The file is located in`./code/python`.

This file implements the generation of the Index Array from a Matrix and performs multiplication using the Index Array and an input vector to validate the functionality. Similarly, two functions are used for generating the Index Array, resulting in the same final multiplication result. It is worth noting that although the two functions store the location information in the Index Array slightly differently, it does not affect the correctness of the results. The improvement in the latter method primarily lies in the runtime speed.

In the Test section of this code, only a single test is demonstrated. However, prior to this, thousands of tests were conducted with different input vectors, ensuring the accuracy of the results.

### matmul_baseline

The file is located in`./code/Vivado Project`.

This file is a Vivado project that includes all the generated Verilog design files and a simple testbench for demonstrating the validation of a single input.

- `matrix_single_bit.v` defines a module named `matrix_mult_single_bit`, which is utilized to perform the multiplication of a single-bit input with a hardcoded matrix.
- `matmul_hardcoded.sv` defines a module named `matmul_hardcoded`, which is used to perform the multiplication of a vector with a hardcoded matrix.
- `matmul_generate.sv` file implements the same design as `matmul_hardcoded.sv`, with the only difference being that the product is achieved through a generate loop. Compared to `matmul_hardcoded.sv`, it is more concise, but it is not sufficient to be considered a standalone Baseline matrix multiplication design.
- `matrix_mult_baseline_3x3.v` defines a module named `matrix_mult`, which performs the multiplication of a vector with a hardcoded matrix, utilizing shift-and-add methods for optimization. The inclusion of "3x3" in the name is due to the test case matrix size being 3x3. However, in practice, it can vary based on the dimensions of the matrices used.
-  `matrix_multiplier_93.sv` file implements the Verilog design of the optimized matrix multiplication algorithm, which obtains the product of a matrix and a vector through shifting and addition operations. The inclusion of "93" in the name is due to the test case where the MEM array is used up to MEM[93]. This value may vary depending on the specific matrix being used.

To evaluate the resource consumption of different Verilog designs for matrix multiplication algorithms, one can create a new project, add the corresponding design files, and perform synthesis by clicking on the synthesis button. If you wish to compare the resource consumption for different input vector bit widths, you only need to modify the input vector bit width value before each synthesis.