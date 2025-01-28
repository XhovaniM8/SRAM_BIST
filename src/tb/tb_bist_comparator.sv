module tb_bist_comparator();

    // Testbench signals
    logic [7:0] data_t;
    logic [7:0] ramout;
    logic gt;
    logic eq;
    logic lt;

    // Instantiate bist_comparator
    bist_comparator uut (
        .data_t(data_t),
        .ramout(ramout),
        .gt(gt),
        .eq(eq),
        .lt(lt)
    );

    initial begin

        // initialize fsdb dump file
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars();

        data_t = 4'b00000000;
        ramout = 4'b00000000;

        #10;
        data_t = 4'b00010000;
        ramout = 4'b00000000;

        #10;
        data_t = 4'b0010000;
        ramout = 4'b0000000;

        #10;
        data_t = 4'b00100000;
        ramout = 4'b00010000;

        #10;
        data_t = 4'b00100000;
        ramout = 4'b00110000;

        #10;
        data_t = 4'b01010000;
        ramout = 4'b01010000;

        #10;
        data_t = 4'b10100000;
        ramout = 4'b10100000;

        #10;
        data_t = 4'b11110000;
        ramout = 4'b11110000;

        $finish; // End the simulation
    end

endmodule

