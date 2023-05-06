`timescale 1ns / 1ps

module Load_tb();

    // Inputs
    reg [31:0] instruction_data;
    reg [31:0] data_address;
    reg [31:0] read_data;
    
    // Outputs
    wire [31:0] out;
    
    // Instantiate the module
    Load dut (
        .instruction_data(instruction_data),
        .data_address(data_address),
        .read_data(read_data),
        .out(out)
    );
    
    // Clock generation
    reg clk = 0;
    always #5 clk = ~clk;
    
    // Test sequence
    initial begin
        
        // Load a 32-bit value from memory
        instruction_data = 32'b0000_0000_0000_0000_0000_0000_0000_0010; // Opcode: 010 (LoadWord)
        data_address = 32'h1000;
        read_data = 32'hABCDEF12;
        #10;
       
        
        // Load a 16-bit value from memory
        instruction_data = 32'b0000_0000_0000_0000_0000_0000_0000_0001; // Opcode: 001 (LoadHalf)
        data_address = 32'h1002;
        read_data = 32'h1234ABCD;
        #10;
     
        
        // Load a signed 8-bit value from memory
        instruction_data = 32'b0000_0000_0000_0000_0000_0000_0000_0100; // Opcode: 100 (LoadByte)
        data_address = 32'h1003;
        read_data = 32'hFFFFFF80;
        #10;
       
        
        // Load an unsigned 8-bit value from memory
        instruction_data = 32'b0000_0000_0000_0000_0000_0000_0000_0000; // Opcode: 000 (LoadByteU)
        data_address = 32'h1004;
        read_data = 32'h7F;
        #10;
       
        
        // End simulation
        #10;
        $display("All tests passed");
        $finish;
    end
    
endmodule