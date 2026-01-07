//=============================================================================================
// File: dff.v
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Design module for a standard D-Flip Flop (DFF).
//              Implements synchronous active-high reset logic where output 'q' 
//              follows input 'd' on the clock edge unless reset is asserted.
//=============================================================================================

module dff (
    input  wire clk,    // Clock signal
    input  wire rst,    // Synchronous Reset signal (Active High)
    input  wire d,      // Data input
    output reg  q       // Data output
);

    //-------------------------------------------------------------------------
    // Sequential Logic Block
    // Logic is triggered only on the positive edge of the clock
    //-------------------------------------------------------------------------
    always @(posedge clk) begin
        // Check for Synchronous Reset first (Priority logic)
        if (rst) begin
            // Active High Reset: Force output 'q' to logic 0
            q <= 1'b0;
        end
        else begin
            // Normal Operation: Pass input 'd' to output 'q'
            // Uses Non-Blocking Assignment (<=) for sequential logic
            q <= d;
        end
    end

endmodule
