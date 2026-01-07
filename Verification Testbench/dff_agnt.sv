//=============================================================================================
// File: dff_agnt.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: UVM Agent that encapsulates the Sequencer, Driver, and Monitor.
//              Responsible for creating and connecting these components.
//=============================================================================================

class dff_agnt extends uvm_agent;
    
    // Factory Registration
    `uvm_component_utils(dff_agnt)
    
    // Constructor
    `NEW_COMP

    //-------------------------------------------------------------------------
    // Component Handles
    //-------------------------------------------------------------------------
    dff_drv drv;    // Driver instance
    dff_mon mon;    // Monitor instance
    dff_sqr sqr;    // Sequencer instance

    //-------------------------------------------------------------------------
    // Build Phase
    // Creates the Driver, Monitor, and Sequencer using the Factory
    //-------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        sqr = dff_sqr::type_id::create("sqr", this);
        drv = dff_drv::type_id::create("drv", this);
        mon = dff_mon::type_id::create("mon", this);
    endfunction

    //-------------------------------------------------------------------------
    // Connect Phase
    // Connects the Driver's seq_item_port to the Sequencer's export
    //-------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect Driver to Sequencer (for pulling transactions)
        drv.seq_item_port.connect(sqr.seq_item_export);
        
        // Coverage connection (Placeholder)
        // mon.ap_port.connect(cov.analysis_export);
    endfunction

endclass
