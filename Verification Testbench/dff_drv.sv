//=============================================================================================
// File: dff_drv.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: UVM Driver class responsible for driving transactions to the DUT interface.
//              Fetches sequence items from the sequencer and drives them via the clocking block.
//=============================================================================================

class dff_drv extends uvm_driver#(dff_tx);
    
    // Factory Registration
    `uvm_component_utils(dff_drv)
    
    // Constructor
    `NEW_COMP
    
    // Interface Handle
    virtual dff_intf vif;
    
    // Transaction Handle
    dff_tx tx;
    
    //-------------------------------------------------------------------------
    // Build Phase
    // Gets the interface from the configuration DB and initializes the transaction handle
    //-------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tx = new();
        
        // Retrieve interface from config_db, assert error if fails
        assert(uvm_config_db#(virtual dff_intf)::get(this, "", "vif", vif));
    endfunction

    //-------------------------------------------------------------------------
    // Run Phase
    // Main driver loop: Get item -> Drive -> Print -> Item Done
    //-------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        forever begin
            // 1. Get the next transaction from the sequencer
            seq_item_port.get_next_item(tx);
            
            // 2. Drive the signals to the interface
            drive(tx);
            
            // 3. Print transaction for debugging
            tx.print();
            
            // 4. Signal completion to the sequencer
            seq_item_port.item_done();       
        end  
    endtask
    
    //-------------------------------------------------------------------------
    // Drive Task
    // Synchronizes with the clocking block and drives the transaction values
    //-------------------------------------------------------------------------
    task drive(dff_tx tx);
        // Wait for the driver clocking block edge
        @(vif.drv_cb);
        
        // Drive input 'd' (Non-blocking assignment to clocking block var)
        vif.drv_cb.d <= tx.d;
        
        // Note: 'rst' driving logic is not present here, ensure this is intended
    endtask
    
endclass
