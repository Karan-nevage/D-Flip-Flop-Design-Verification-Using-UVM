//=============================================================================================
// File: dff_seq_lib.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Sequence library containing the base sequence and specific test sequences.
//              - base_seq: Handles raising and dropping objections automatically.
//              - basic_seq: Generates a stream of random transactions.
//=============================================================================================

//=============================================================================================
// Class: base_seq
// Description: Base sequence that manages objections in pre/post body tasks.
//=============================================================================================
class base_seq extends uvm_sequence#(dff_tx);
    
    dff_tx tx;          // Transaction handle
    uvm_phase phase;    // Phase handle for objections
    
    // Factory Registration
    `uvm_object_utils(base_seq)
    
    // Constructor
    `NEW_OBJ
    
    //-------------------------------------------------------------------------
    // Pre-Body Task
    // Raises objection if a starting phase exists (i.e., if started as a default sequence)
    //-------------------------------------------------------------------------
    task pre_body();
        phase = get_starting_phase();                   // Get current phase
        if (phase != null) begin                        // Check phase is empty or not
            phase.raise_objection(this);                // Raise the objection
            phase.phase_done.set_drain_time(this, 10);  // Set drain time
        end
    endtask 
    
    //-------------------------------------------------------------------------
    // Post-Body Task
    // Drops objection to allow simulation to proceed/finish
    //-------------------------------------------------------------------------
    task post_body();
        if (phase != null) 
            phase.drop_objection(this);
    endtask
    
endclass


//=============================================================================================
// Class: basic_seq
// Description: Basic sequence that generates 50 random transactions.
//=============================================================================================
class basic_seq extends base_seq;
    
    // Factory Registration
    `uvm_object_utils(basic_seq)
    
    // Constructor
    `NEW_OBJ
    
    //-------------------------------------------------------------------------
    // Body Task
    // Main sequence execution: Create -> Start -> Randomize -> Finish
    //-------------------------------------------------------------------------
    task body();
        repeat (50) begin
            tx = dff_tx::type_id::create("tx");
            
            start_item(tx);
            
            if (!tx.randomize()) 
                `uvm_error("SEQ", "Randomization failed for tx");
            
            finish_item(tx);
        end     
    endtask
    
endclass
