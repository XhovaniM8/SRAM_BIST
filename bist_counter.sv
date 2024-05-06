// Parameterized Counter Module
// This module can act as an up or down counter with load and enable control.
module bist_counter #(
    parameter length = 10  // Bit-width of the counter
) (
    input [length-1:0] d_in,  // Initial value to load into the counter
    input clk,                // Clock signal
    input ld,                 // Load enable signal (active high)
    input u_d,                // Up/Down control signal (1 for up, 0 for down)
    input cen,                // Counter enable signal (active high)
    output [length-1:0] q,    // Counter output value
    output cout               // Carry-out signal (indicates overflow/underflow)
);

    // Internal register for storing the counter value, plus an extra bit for carry-out
    reg [length:0] cnt_reg;

    // Sequential logic to update the counter value on every rising clock edge
    always @(posedge clk) begin
        if (cen) begin
            if (ld) begin
                // Load the counter with the specified initial value
                cnt_reg <= {1'b0, d_in};  // Prefix zero to match the extra carry-out bit
            end else if (u_d) begin
                // Increment the counter when `u_d` is 1
                cnt_reg <= cnt_reg + 1;
            end else begin
                // Decrement the counter when `u_d` is 0
                cnt_reg <= cnt_reg - 1;
            end
        end
    end

    // Extract the lower `length` bits as the counter output
    assign q = cnt_reg[length-1:0];

    // The highest bit of `cnt_reg` serves as the carry-out flag
    assign cout = cnt_reg[length];

endmodule
module bist_decoder (
    input logic [2:0] q,        // 3-bit selector input
    output logic [7:0] data_t   // 8-bit test pattern output
);

    // This module decodes the 3-bit selector into an 8-bit test pattern
    // that is output based on the input pattern selector `q`.
    always_comb begin
        case (q)
            // Checkerboard pattern
            3'b000: data_t = 8'b10101010;
            3'b001: data_t = 8'b01010101;

            // Reverse Checkerboard pattern
            3'b010: data_t = 8'b11110000;
            3'b011: data_t = 8'b00001111;

            // Blanket 0 pattern
            3'b100: data_t = 8'b00000000;

            // Blanket 1 pattern
            3'b101: data_t = 8'b11111111;

            // March C- patterns:
            3'b110: data_t = 8'b00000000; // Write 0 pattern
            3'b111: data_t = 8'b11111111; // Write 1 pattern

            // March A patterns
            3'b110: data_t = 8'b00001111; // Example: Write '0', then '1'
            3'b111: data_t = 8'b11110000; // Example: Read '1', then '0'

            // Default case (high impedance state)
            default: data_t = 8'bzzzzzzzz;
        endcase
    end
endmodule
