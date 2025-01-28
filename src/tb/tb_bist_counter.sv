module tb_bist_counter();

    // Parameters
    parameter int LENGTH = 10;

    // Testbench signals
    logic clk;
    logic ld;
    logic u_d;
    logic cen;
    logic [LENGTH-1:0] d_in;
    logic [LENGTH-1:0] q;
    logic cout;

    // Instantiate bist_counter
    bist_counter #(LENGTH) uut (
        .d_in(d_in),
        .clk(clk),
        .ld(ld),
        .u_d(u_d),
        .cen(cen),
        .q(q),
        .cout(cout)
    );

    // Clock generation
    initial begin
	clk <= 0;
        forever #5 clk = ~clk;
    end

    // Test sequences
    initial begin

        // initialize fsdb dump file
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars();
        
        // Initialize inputs
        d_in = 'd0;
        ld = 1'b0;
        u_d = 1'b1; // Up count
        cen = 1'b0;

        #10; // Wait for a bit

        // Test case 1: Load
        d_in = 'd5;
        ld = 1'b1;
        cen = 1'b1;
        #10; // Wait for a bit
        ld = 1'b0;
        #20; // Wait for a bit

        // Test case 2: Up count
        u_d = 1'b1;
        cen = 1'b1;
        #50; // Wait for a bit

        // Test case 3: Down count
        u_d = 1'b0;
        #50; // Wait for a bit

        $finish; // End the simulation
    end

    // Monitor to observe the outputs
    initial begin
        $monitor("At time %0dns: q = %b, cout = %b", $time, q, cout);
    end

endmodule

