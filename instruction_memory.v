`timescale 1ns / 1ps

module instruction_memory(
    input [31:0] instruction_address,
    output [31:0] instruction_data
);
assign instruction_data= instruction_address;
endmodule