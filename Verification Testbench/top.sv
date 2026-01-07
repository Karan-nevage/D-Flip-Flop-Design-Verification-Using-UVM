//=============================================================================================
// File: top.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Top-level testbench module.
//              - Generates the system clock and reset.
//              - Instantiates the DUT (DFF) and Interface.
//              - Sets the virtual interface in the UVM config DB.
//              - Starts the UVM test.
//=============================================================================================

module top;

    logic clk;
    logic rst;

    //-------------------------------------------------------------------------
    // Clock and Reset Initialization
    //-------------------------------------------------------------------------
    initial begin 
        clk = 0;            // Initialize clock
        rst = 1;            // Apply Reset (Active High)
        #20 rst = 0;        // De-assert Reset after 20ns 
    end
    
    //-------------------------------------------------------------------------
    // Clock Generation
    // 10ns Time Period (100 MHz Frequency)
    //-------------------------------------------------------------------------
    always #5 clk = ~clk;
    
    //-------------------------------------------------------------------------
    // Interface Instantiation
    //-------------------------------------------------------------------------
    dff_intf vif(
        .clk(clk),
        .rst(rst)
    );
    
    //-------------------------------------------------------------------------
    // DUT Instantiation
    // Connects Interface signals to the DFF ports
    //-------------------------------------------------------------------------
    dff dut(
        .clk(vif.clk),
        .rst(vif.rst),
        .d(vif.d),
        .q(vif.q)
    ); 
    
    //-------------------------------------------------------------------------
    // Configuration DB Setup
    // Register the physical interface handle into the UVM configuration DB
    //-------------------------------------------------------------------------
    initial begin
        uvm_config_db#(virtual dff_intf)::set(null, "*", "vif", vif);
    end

    //-------------------------------------------------------------------------
    // Start Test
    // Invokes the UVM test specified (can be overridden via command line)
    //-------------------------------------------------------------------------
    initial begin
        run_test("basic_test");
    end

    //-------------------------------------------------------------------------
    // Waveform Dumping
    //-------------------------------------------------------------------------
    initial begin
        // $monitor("time: %t | clk: %b", $time , clk);
        $dumpfile("dump.vcd");
        $dumpvars();
    end

endmodule
