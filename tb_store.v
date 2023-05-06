`timescale 1ns / 1ps

module Store_tb();

    // Inputs
    reg [31:0] instruction_data;
    reg [31:0] data_address;
    
    // Outputs
    wire [3:0] write_enable;
    
    // Instantiate the module
    Store dut (
        .instruction_data(instruction_data),
        .data_address(data_address),
        .write_enable(write_enable)
    );
    
    // Clock generation
    reg clk = 0;
    always #5 clk = ~clk;
    
    // Test sequence
    initial begin
        
        // Store a byte to memory
        instruction_data = 32'b0000_0000_0000_0000_0000_0000_0000_0000; // Opcode: 000 (StoreByteU)
        data_address = 32'h1000;
        #10;
       
        // Store a halfword to memory
        instruction_data = 32'b0000_0000_0000_0000_0000_0000_0000_0001; // Opcode: 001 (StoreHalf)
        data_address = 32'h1002;
        #10;
        
        
        // Store a word to memory
        instruction_data = 32'b0000_0000_0000_0000_0000_0000_0000_0010; // Opcode: 010 (StoreWord)
        data_address = 32'h1004;
        #10;
        
        
        // End simulation
        #10;
        $display("All tests passed");
        $finish;
    end
    
endmodule