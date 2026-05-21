module acc (
    input  logic       clk,
    input  logic       reset,
    input  logic       acc_write,
    input  logic [7:0] data_in,
    output logic [7:0] data_out
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            data_out <= 8'd0;
        else if (acc_write)
            data_out <= data_in;
    end

endmodule