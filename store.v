`timescale 1ns / 1ps

module Store(
    input [31:0] instruction_data,
    input [31:0] data_address,
    output reg[3:0] write_enable
);
    always@(instruction_data or data_address)
    begin   
        case(instruction_data[14:12])
        3'b000: write_enable = (4'b0001)<<daddr[1:0];     //SB
        3'b001: write_enable = (4'b0011)<<daddr[1:0];     //SH
        3'b010: write_enable = 4'b1111;                   //SW
        endcase
    end
endmodule