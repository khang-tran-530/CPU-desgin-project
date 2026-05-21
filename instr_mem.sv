module instr_mem (
    input  logic [7:0] addr,
    output logic [8:0] instr
);

    always_comb begin
        case (addr)
            8'd0: instr = 9'b0000_00000; // NOP
            8'd1: instr = 9'b0001_00000; // LDA 0
            8'd2: instr = 9'b0010_00001; // STA 1
            8'd3: instr = 9'b1111_00000; // DONE
            default: instr = 9'b0000_00000;
        endcase
    end

endmodule