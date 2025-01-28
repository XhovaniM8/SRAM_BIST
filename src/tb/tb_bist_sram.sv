module tb_bist_sram();
    // Testbench signals
    logic clk;
    logic we;
    logic [7:0] ramaddr;
    logic [3:0] ramin;
    logic [3:0] ramout;

    // Instantiate bist_sram
    bist_sram uut (
        .ramaddr(ramaddr),
        .ramin(ramin),
        .we(we),
        .clk(clk),
        .ramout(ramout)
    );
    // Clock generation
    always begin
        #5 clk = ~clk;  // Toggle clk every 5 time units
    end
    // Test sequences
    initial begin
        // initialize fsdb dump file
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars();
        // Initialize signals
        clk = 0;
        we = 0;
        ramaddr = 'd0;
        ramin = 'd0;
        #10; // Wait for some time
        // Write data to the SRAM
        we = 1;
        for (int i = 0; i < 255; i++) begin
            ramaddr = i;
            ramin = i[3:0]; // Write lower 4 bits of the address as data
            #10; // Wait for a clock cycle
        end
        we = 0; // Stop writing
        // Read and check data from the SRAM

        for (int i = 0; i < 255; i++) begin
            ramaddr = i;
            #10; // Wait for a clock cycle
            assert(ramout == i[3:0]) else $error("Data mismatch at address %0d. Expected: %0b, got: %0b", i, i[3:0], ramout);
        end
        $finish; // End the simulation
    end
endmodule


