module tb_bist_decoder();

    // Testbench signals
    logic [2:0] q;
    logic [7:0] data_t;

    // Instantiate bist_decoder
    bist_decoder uut (
        .q(q),
        .data_t(data_t)
    );

    // Test sequences
    initial begin

        // initialize fsdb dump file
        $fsdbDumpfile("bist.fsdb");
        $fsdbDumpvars();
        
        // Initialize inputs
        q = 'd0;

        // Test all possible values of q
        for (int i = 0; i < 8; i++) begin
            q = i;
            #10; // Wait for a bit
        end

        $finish; // End the simulation
    end

    // Monitor to observe the output
    initial begin
        $monitor("At time %0dns: q = %b, data_t = %b", $time, q, data_t);
    end

endmodule

