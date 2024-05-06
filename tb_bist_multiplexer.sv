module tb_bist_multiplexer();

    parameter ADDR_WIDTH = 6;
    parameter DATA_WIDTH = 8;

    // Testbench signals
    logic [ADDR_WIDTH-1:0] normal_addr;
    logic [DATA_WIDTH-1:0] normal_data;
    logic [ADDR_WIDTH-1:0] bist_addr;
    logic [DATA_WIDTH-1:0] bist_data;
    logic NbarT;
    logic [ADDR_WIDTH-1:0] mem_addr;
    logic [DATA_WIDTH-1:0] mem_data;

    // Instantiate bist_multiplexer
    bist_multiplexer #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .normal_addr(normal_addr),
        .normal_data(normal_data),
        .bist_addr(bist_addr),
        .bist_data(bist_data),
        .NbarT(NbarT),
        .mem_addr(mem_addr),
        .mem_data(mem_data)
    );

    initial begin

        // initialize fsdb dump file
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars();

        // Initialization
        normal_addr = 'h0;
        normal_data = 'h0;
        bist_addr = 'h0;
        bist_data = 'h0;
        NbarT = 1'b0;

        #10;

        // Normal mode
        normal_addr = 'hA5;  // Random values
        normal_data = 'h5;

        #10;

        // BIST mode
        NbarT = 1'b1;

        bist_addr = 'h5A;
        bist_data = 'hA;

        #10;

        // Back to normal mode
        NbarT = 1'b0;

        #10;

        // Change values in normal mode
        normal_addr = 'h55;
        normal_data = 'hA;

        #10;

        // Change to BIST mode and change values
        NbarT = 1'b1;

        bist_addr = 'hAA;
        bist_data = 'h5;

        #10;

        // Test done, finish the simulation
        $finish;
    end

    // // Monitor
    // always @(posedge NbarT, posedge normal_addr, posedge normal_data, posedge bist_addr, posedge bist_data) begin
    //     $display("At time %t, NbarT = %b, normal_addr = %h, normal_data = %h, bist_addr = %h, bist_data = %h, mem_addr = %h, mem_data = %h",
    //              $time, NbarT, normal_addr, normal_data, bist_addr, bist_data, mem_addr, mem_data);
    // end

endmodule

