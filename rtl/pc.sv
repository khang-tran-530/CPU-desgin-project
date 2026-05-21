module pc (
    input  logic       clk,
    input  logic       reset,
    input  logic       start,
    input  logic       branch_taken,
    input  logic [4:0] target,
    output logic [7:0] pc_out
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 8'd0;
        else if (start)
            pc_out <= pc_out;
        else if (branch_taken)
            pc_out <= {3'b000, target};
        else
            pc_out <= pc_out + 8'd1;
    end

endmodule