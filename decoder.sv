module decoder (
    input  logic [3:0] opcode,
    input  logic       z,
    input  logic       c,

    output logic       acc_write,
    output logic       mem_write,
    output logic       use_mem,
    output logic       branch_taken,
    output logic       done
);

    always_comb begin
        acc_write    = 1'b0;
        mem_write    = 1'b0;
        use_mem      = 1'b0;
        branch_taken = 1'b0;
        done         = 1'b0;

        case (opcode)
            4'b0001: begin // LDA
                acc_write = 1'b1;
                use_mem = 1'b1;
            end

            4'b0010: begin // STA
                mem_write = 1'b1;
            end

            4'b0011, // ADD
            4'b0100, // SUB
            4'b0101, // XOR
            4'b0110, // AND
            4'b0111, // SHL
            4'b1000, // SHR
            4'b1001, // INC
            4'b1010: begin // DEC
                acc_write = 1'b1;
            end

            4'b1011: begin // JMP
                branch_taken = 1'b1;
            end

            4'b1100: begin // JZ
                branch_taken = z;
            end

            4'b1101: begin // JNZ
                branch_taken = ~z;
            end

            4'b1110: begin // JC
                branch_taken = c;
            end

            4'b1111: begin // DONE
                done = 1'b1;
            end
        endcase
    end

endmodule