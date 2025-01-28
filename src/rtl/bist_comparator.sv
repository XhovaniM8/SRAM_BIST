// Comparator Module to compare two 8-bit inputs
module bist_comparator (
    input logic [7:0] a,       // First 8-bit input
    input logic [7:0] b,       // Second 8-bit input
    output logic a_gt_b,       // Indicates if `a` is greater than `b`
    output logic a_eq_b,       // Indicates if `a` is equal to `b`
    output logic a_lt_b        // Indicates if `a` is less than `b`
);

    // Combinational logic to compare the inputs
    always_comb begin
        // Initialize all comparison outputs to zero
        a_gt_b = 0;
        a_eq_b = 0;
        a_lt_b = 0;

        // Determine the relationship between `a` and `b`
        if (a < b) begin
            a_lt_b = 1;
        end else if (a > b) begin
            a_gt_b = 1;
        end else begin
            a_eq_b = 1; // If neither greater nor less, `a` must be equal to `b`
        end
    end

endmodule
