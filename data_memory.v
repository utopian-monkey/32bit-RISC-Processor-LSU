
`timescale 1ns / 1ps

module data_memory(
    input clk,
    input [31:0] data_address,
    input [31:0] write_data,
    input [3:0] write_enable,
    output [31:0] read_data
);

    reg [7:0] m[0:31];

    initial begin
        m[3] = 8'b10010110;
        m[2] = 8'b11001001;
        m[1] = 8'b10100111;
        m[0] = 8'b10110001;
    end

    reg [31:0] read_data_reg;
always @(*) begin
    read_data_reg = {m[data_address[5:2]], m[data_address[5:2]+1], m[data_address[5:2]+2], m[data_address[5:2]+3]};
end
assign read_data = read_data_reg;

    always @(posedge clk) begin
        if (write_enable != 0) begin
            if (write_enable[0]) m[data_address[1:0]] <= write_data[7:0];
            if (write_enable[1]) m[data_address[1:0]+1] <= write_data[15:8];
            if (write_enable[2]) m[data_address[1:0]+2] <= write_data[23:16];
            if (write_enable[3]) m[data_address[1:0]+3] <= write_data[31:24];
        end
    end

endmodule