//=============================================================================================
// File: dff_mon.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: UVM Monitor class responsible for sampling signal activity.
//              Captures transactions from the interface and broadcasts them to the scoreboard.
//=============================================================================================

class dff_mon extends uvm_monitor;
    
    // Factory Registration
    `uvm_component_utils(dff_mon)
    
    // Constructor
    `NEW_COMP

    //-------------------------------------------------------------------------
    // Class Members
    //-------------------------------------------------------------------------
    dff_tx tx;                          // Transaction handle for sampling
    virtual dff_intf vif;               // Virtual Interface handle
    uvm_analysis_port #(dff_tx) ap_port;// Analysis port to broadcast transactions

    //-------------------------------------------------------------------------
    // Build Phase
    // Creates the analysis port and retrieves the virtual interface
    //-------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Create the analysis port
        ap_port = new("ap_port", this);
        
        // Create the transaction object using factory
        tx = dff_tx::type_id::create("tx");  
        
        // Get interface from config_db
        assert(uvm_config_db#(virtual dff_intf)::get(this, "", "vif", vif));
    endfunction

    //-------------------------------------------------------------------------
    // Run Phase
    // Main monitoring loop: Wait for Reset -> Sample Signals -> Write to Port
    //-------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        forever begin
            // Debug prints (optional)
            $display($time);
            tx.print();
            $display($time);
            
            // Wait for Reset to be de-asserted (Active High Logic assumed)
            wait(!vif.rst); 
            
            // Wait for the Monitor Clocking Block edge
            @(vif.mon_cb);
            
            // Sample signals via Clocking Block
            // Note: vif.mon_cb.q uses input #0 skew (defined in interface) 
            // to capture the updated value in the current cycle.
            tx.rst = vif.mon_cb.rst;
            tx.d   = vif.mon_cb.d;
            tx.q   = vif.mon_cb.q;
            
            // Log the sampled value
            `uvm_info("MON", $sformatf("Sampled at %0t: q=%0b", $time, tx.q), UVM_LOW)
            
            // Broadcast transaction to Scoreboard
            ap_port.write(tx);
        end
    endtask
    
endclass
