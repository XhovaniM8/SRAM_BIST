// 8-bit Data Multiplexer
// Selects between two 8-bit data inputs based on the select signal.
module muxd (
    input logic [7:0] i0,  // First 8-bit data input
    input logic [7:0] i1,  // Second 8-bit data input
    input logic s,         // Select signal (0 selects i0, 1 selects i1)
    output logic [7:0] y   // Selected 8-bit data output
);

    // Assign the output based on the select signal
    assign y = s ? i1 : i0;

endmodule
