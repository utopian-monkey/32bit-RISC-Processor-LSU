`timescale 1ns / 1ps

module controller (
    input clk,
    input reset,
    output reg[31:0] instruction_address,
    output reg[31:0] program_counter,
)

reg [3:0] write_enable;
reg wer;
wire [31:0] regdata_load;
wire[3:0] we_store;
wire[31:0] instruction_data,rs1_value,rs2_value;
reg[31:0] register_data, write_data ,data_address,read_data;
reg[4:0] rd,rs1,rs2;
reg signed[31:0] imm;

always@(posedge clk)
    begin
        if(reset)
            instruction_address = 0;
        else
            instruction_address = pc;
    end 

instruction_memory im1(instruction_address,instruction_data);
data_memory d1(clk,data_address,write_data,write_enable,read_data);
register_array ra1(clk,rs1,rs2,rd,register_data,wer,rs1_value,rs2_value);

always
begin
    case(instruction_data[6:0])
        7'b0000011:     //Load instructions
        begin
            rd = instruction_data[11:7];
            rs1 = instruction_data[19:15]; 
            imm = {{20{instruction_data[31]}},instruction_data[31:20]};
            wer=1;
            write_enable=4'b0;
            data_address = rs1_value+imm;    
            register_data = register_data_L;
			pc = instruction_address+4;
        end
        7'b0100011:     //Store instructions
        begin
            rs1 = instruction_data[19:15];
            rs2 = instruction_data[24:20];
            imm = {{20{instruction_data[31]}},instruction_data[31:25],instruction_data[11:7]};
                wer=0;
                data_address = rs1_value+imm;
					 case(instruction_data[14:12])
					 3'b000: write_data = {rs2_value[7:0],rs2_value[7:0],rs2_value[7:0],rs2_value[7:0]};
					 3'b001: write_data = {rs2_value[15:0],rs2_value[15:0]};
					 3'b010: write_data = rs2_value;
					 endcase
                write_enable = we_store;
					 pc = instruction_address+4;
        end
    endcase
end

Load l1(instruction_data,data_address,read_data,regdata_L);
Store s1(instruction_data,data_address,we_store);

endmodule 