module alu (
    input  logic [7:0] acc,
    input  logic [7:0] mem_data,
    input  logic [3:0] alu_op,
    output logic [7:0] result,
    output logic       z,
    output logic       n,
    output logic       c
);

    logic [8:0] temp;

    always_comb begin
        result = acc;
        c = 1'b0;
        temp = 9'b0;

        case (alu_op)
            4'b0011: begin // ADD
                temp = acc + mem_data;
                result = temp[7:0];
                c = temp[8];
            end

            4'b0100: begin // SUB
                temp = acc - mem_data;
                result = temp[7:0];
                c = temp[8];
            end

            4'b0101: result = acc ^ mem_data; // XOR
            4'b0110: result = acc & mem_data; // AND

            4'b0111: begin // SHL
                c = acc[7];
                result = acc << 1;
            end

            4'b1000: begin // SHR
                c = acc[0];
                result = acc >> 1;
            end

            4'b1001: begin // INC
                temp = acc + 8'd1;
                result = temp[7:0];
                c = temp[8];
            end

            4'b1010: begin // DEC
                result = acc - 8'd1;
            end

            default: result = acc;
        endcase

        z = (result == 8'd0);
        n = result[7];
    end

endmodule