`timescale 1ns / 1ps
module Load(
    input [31:0] instruction_data,
    input [31:0] data_address,
    input [31:0] read_data,
    output reg[31:0] out
);
    
	 reg [31:0] offset;
    always@(instruction_data or data_address or read_data)
    begin   
        offset = (data_address[1:0]<<3);  
        case(instruction_data[14:12])
        3'b000: out = {{24{read_data[offset+7]}}, read_data[offset +: 8]};    
        3'b001: out = {{16{read_data[offset+15]}}, read_data[offset +: 16]};  
        3'b010: out = read_data;                                   			
        3'b100: out = {24'b0, read_data[offset +: 8]};             			
        3'b101: out = {16'b0, read_data[offset +: 16]};            			
        endcase
    end
endmodule