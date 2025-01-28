module tb_bist_controller();

    // Testbench signals
    logic start;
    logic rst;
    logic clk;
    logic cout;
    logic NbarT;
    logic ld;

    // Instantiate bist_controller
    bist_controller uut (
        .start(start),
        .rst(rst),
        .clk(clk),
        .cout(cout),
        .NbarT(NbarT),
        .ld(ld)
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
        start = 1'b0;
        rst = 1'b0;
        cout = 1'b0;

        #10; // Wait for a bit
        // Test case 1: Test reset
        rst = 1'b1;
        #10; // Wait for a bit
        rst = 1'b0;
        #10; // Wait for a bit

        // Test case 2: Test start
        start = 1'b1;
        #10; // Wait for a bit
        start = 1'b0;
        #10; // Wait for a bit

        // Test case 3: Test cout
        cout = 1'b1;
        #10; // Wait for a bit
        cout = 1'b0;
        #10; // Wait for a bit

        $finish; // End the simulation
    end

    // Monitor to observe the outputs
    initial begin
        $monitor("At time %0dns: NbarT = %b, ld = %b", $time, NbarT, ld);
    end

endmodule

