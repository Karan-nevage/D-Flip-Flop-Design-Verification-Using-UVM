//=============================================================================================
// File: dff_sbd.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: UVM Scoreboard class responsible for verifying data integrity.
//              Receives transactions from the Monitor and compares actual vs. expected results.
//=============================================================================================

class dff_sbd extends uvm_scoreboard;
    
    // Factory Registration
    `uvm_component_utils(dff_sbd)
    
    // Constructor
    `NEW_COMP

    //-------------------------------------------------------------------------
    // Class Members
    //-------------------------------------------------------------------------
    dff_tx tx;                                      // Transaction handle
    dff_tx tx_q[$];                                 // Queue to store incoming transactions
    uvm_analysis_imp#(dff_tx, dff_sbd) ap_export;   // Analysis export to receive data

    //-------------------------------------------------------------------------
    // Build Phase
    // Initializes the analysis export and transaction handle
    //-------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        tx = dff_tx::type_id::create("tx");
        ap_export = new("ap_export", this);
    endfunction 

    //-------------------------------------------------------------------------
    // Write Function
    // Implementation of the analysis port write method. Pushes tx to queue.
    //-------------------------------------------------------------------------
    virtual function void write(dff_tx tx);
        tx_q.push_back(tx);     
    endfunction

    //-------------------------------------------------------------------------
    // Run Phase
    // Processes transactions from the queue and performs comparison logic
    //-------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        dff_tx tx;
        
        forever begin
            // Wait until a transaction is available in the queue
            wait(tx_q.size() > 0);
            
            // Pop the front transaction
            tx = tx_q[0];
            tx_q.delete(0);

            //-----------------------------------------------------------------
            // Comparison Logic
            // Check Reset condition first, otherwise check Data integrity
            //-----------------------------------------------------------------
            if (tx.rst) begin
                if (tx.q == 0) 
                    match++;
                else 
                    missmatch++;
            end 
            else begin
                if (tx.q == tx.d) 
                    match++;
                else 
                    missmatch++;
            end
        end
    endtask

    //-------------------------------------------------------------------------
    // Report Phase
    // display the final simulation results
    //-------------------------------------------------------------------------
    virtual function void report_phase(uvm_phase phase);        
        `uvm_info("SBD", $sformatf("Values match: exp_q=%d act_q=%d", match, missmatch), UVM_NONE);
    endfunction
    
endclass
