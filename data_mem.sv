module data_mem (
    input  logic       clk,
    input  logic       mem_write,
    input  logic [4:0] addr,
    input  logic [7:0] write_data,
    output logic [7:0] read_data
);

    logic [7:0] mem [0:31];

    assign read_data = mem[addr];

    always_ff @(posedge clk) begin
        if (mem_write)
            mem[addr] <= write_data;
    end

endmodule