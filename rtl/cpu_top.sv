module cpu_top (
    input  logic clk,
    input  logic reset,
    input  logic start,
    output logic done
);

    logic [7:0] pc_out;
    logic [8:0] instr;
    logic [3:0] opcode;
    logic [4:0] operand;

    logic [7:0] acc_out;
    logic [7:0] alu_result;
    logic [7:0] mem_data;

    logic z, n, c;
    logic acc_write;
    logic mem_write;
    logic use_mem;
    logic branch_taken;

    assign opcode = instr[8:5];
    assign operand = instr[4:0];

    pc PC_UNIT (
        .clk(clk),
        .reset(reset),
        .start(start),
        .branch_taken(branch_taken),
        .target(operand),
        .pc_out(pc_out)
    );

    instr_mem IMEM (
        .addr(pc_out),
        .instr(instr)
    );

    data_mem DMEM (
        .clk(clk),
        .mem_write(mem_write),
        .addr(operand),
        .write_data(acc_out),
        .read_data(mem_data)
    );

    alu ALU_UNIT (
        .acc(acc_out),
        .mem_data(mem_data),
        .alu_op(opcode),
        .result(alu_result),
        .z(z),
        .n(n),
        .c(c)
    );

    acc ACC_REG (
        .clk(clk),
        .reset(reset),
        .acc_write(acc_write),
        .data_in(use_mem ? mem_data : alu_result),
        .data_out(acc_out)
    );

    decoder DECODER_UNIT (
        .opcode(opcode),
        .z(z),
        .c(c),
        .acc_write(acc_write),
        .mem_write(mem_write),
        .use_mem(use_mem),
        .branch_taken(branch_taken),
        .done(done)
    );

endmodule