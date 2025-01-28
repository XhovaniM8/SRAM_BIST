// 6-bit Address Multiplexer
// Selects between two 6-bit input addresses based on the select signal.
module muxa (
    input logic [5:0] i0,  // First 6-bit input address
    input logic [5:0] i1,  // Second 6-bit input address
    input logic s,         // Select signal (0 selects i0, 1 selects i1)
    output logic [5:0] y   // Selected 6-bit output address
);

    // Assign the output based on the select signal
    assign y = s ? i1 : i0;

endmodule
