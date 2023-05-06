`timescale 1ns / 1ps
    
module register_array(
    input clk,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] register_data,
    input wer,
    output [31:0] rs1_value,
    output [31:0] rs2_value,
	
);
    reg [31:0] ra[0:31];
    integer i;
    initial begin
		ra[31] = 0;
        for(i=0; i<31; i = i+1)
            ra[i]=i;
    end
    assign rs1_value = ra[rs1];
    assign rs2_value = ra[rs2];
    always @(posedge clk) 
    begin
        if(wer && rd!=0)
            r[rd] = register_data;
    end
endmodule