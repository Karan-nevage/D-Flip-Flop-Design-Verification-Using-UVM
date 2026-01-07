//=============================================================================================
// File: dff_intf.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Defines the interface for connecting the DUT to the UVM testbench.
//              Includes signal declarations and clocking blocks for driver and monitor.
//=============================================================================================

interface dff_intf(input logic clk, input logic rst);
    
    logic d;
    logic q;

    // Clocking block for driver
    clocking drv_cb @(posedge clk);
        default input #1step output #1;
        output d;
        output rst;
    endclocking

    // Clocking block for monitor
    clocking mon_cb @(posedge clk);
        default input #1step output #1;
        input #0 q;   // Sampling with #0 to capture the updated value (Post-NBA)
        input d;
        input rst;
    endclocking

endinterface
