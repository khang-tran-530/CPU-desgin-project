`timescale 1ns/1ps

module tb_cpu;

    logic clk;
    logic reset;
    logic start;
    logic done;

    cpu_top DUT (
        .clk(clk),
        .reset(reset),
        .start(start),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        start = 0;

        // Put test value into data memory address 0
        DUT.DMEM.mem[0] = 8'd7;

        #10;
        reset = 0;

        // Let CPU run
        #100;

        $display("MEM[0] = %0d", DUT.DMEM.mem[0]);
        $display("MEM[1] = %0d", DUT.DMEM.mem[1]);
        $display("DONE = %0d", done);

        if (DUT.DMEM.mem[1] == 8'd7 && done == 1'b1)
            $display("TEST PASSED");
        else
            $display("TEST FAILED");

        $stop;
    end

endmodule