// BIST Controller FSM to manage the BIST testing process
module bist_controller (
    input logic start,   // Signal to start the test
    input logic rst,     // Reset signal
    input logic clk,     // Clock signal
    input logic cout,    // Carry-out from the counter
    output logic NbarT,  // Test Enable signal (active high)
    output logic ld      // Load signal for the counter
);
    // State encoding
    typedef enum logic {
        RESET = 1'b0,    // Reset state
        TEST = 1'b1      // Testing state
    } state_t;

    // Register to hold the current state
    state_t current, next;

    // Sequential logic to update the state on every clock edge
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current <= RESET;  // Go to reset state if `rst` is high
        else
            current <= next;   // Otherwise, move to the next state
    end

    // Combinational logic to determine the next state
    always_comb begin
        next = current;  // Default to remaining in the current state

        case (current)
            RESET: begin
                if (start)
                    next = TEST;  // Start the test if the `start` signal is high
            end
            TEST: begin
                if (cout)
                    next = RESET;  // If counting is complete, go back to reset
            end
            default: begin
                next = RESET;  // Default state is RESET in case of errors
            end
        endcase
    end

    // Assign control signals based on the current state
    assign NbarT = (current == TEST);   // Active high during the TEST state
    assign ld = (current == RESET);     // Load the counter during the RESET state

endmodule
