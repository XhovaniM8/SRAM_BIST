// 64 x 8-bit Single-Port RAM
// Implements a small, 64-location SRAM module with read/write capability.
module bist_ram (
    input [7:0] data,  // 8-bit input data to write to the memory
    input [5:0] addr,  // 6-bit address input for reading/writing data
    input re,          // Read/Write enable signal (0 for write, 1 for read)
    input clk,         // Clock signal for synchronizing memory access
    output [7:0] q     // 8-bit output data read from the memory
);

    // Declare the RAM storage as a 64 x 8-bit array
    reg [7:0] ram [63:0];

    // Register to hold the address for read operations
    reg [5:0] addr_reg;

    // Synchronous process to handle memory read and write operations
    always @(posedge clk) begin
        // Write to the memory location if `re` is low (write enable)
        if (!re)
            ram[addr] <= data;

        // Update the registered address for reading in the next cycle
        addr_reg <= addr;
    end

    // Continuous assignment for the output data
    // Retrieves data from the previously registered address
    assign q = ram[addr_reg];

endmodule
