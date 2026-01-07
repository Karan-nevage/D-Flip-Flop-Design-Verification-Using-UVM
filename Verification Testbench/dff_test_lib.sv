//=============================================================================================
// File: dff_test_lib.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Test library containing the base test and extended test cases.
//              - base_test: Sets up the environment and prints topology.
//              - basic_test: Runs the basic random sequence.
//=============================================================================================

//=============================================================================================
// Class: base_test
// Description: Base test class that instantiates the environment. 
//              Common configuration and printing happen here.
//=============================================================================================
class base_test extends uvm_test;
    
    // Factory Registration
    `uvm_component_utils(base_test)
    
    // Constructor
    `NEW_COMP
    
    // Environment Instance
    dff_env env;
    
    //-------------------------------------------------------------------------
    // Build Phase
    // Creates the environment component
    //-------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = dff_env::type_id::create("env", this);
    endfunction
    
    //-------------------------------------------------------------------------
    // End of Elaboration Phase
    // Prints the UVM topology and Factory overrides for debugging
    //-------------------------------------------------------------------------
    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_factory factory = uvm_factory::get();   // Get factory instance 
        factory.print();                            // Print factory overrides
        uvm_top.print_topology();                   // Print UVM component hierarchy
    endfunction
    
endclass


//=============================================================================================
// Class: basic_test
// Description: Extended test that runs the basic sequence (sanity check).
//=============================================================================================
class basic_test extends base_test;
    
    // Factory Registration
    `uvm_component_utils(basic_test)
    
    // Constructor
    `NEW_COMP
    
    // Sequence Instance
    basic_seq seq;
    
    //-------------------------------------------------------------------------
    // Build Phase
    // Creates the sequence object
    //-------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq = basic_seq::type_id::create("seq", this);
    endfunction
    
    //-------------------------------------------------------------------------
    // Run Phase
    // Raises objection, starts the sequence on the agent's sequencer, 
    // and drops objection after a drain time.
    //-------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        // Set drain time to allow pending transactions to finish
        phase.phase_done.set_drain_time(this, 10);
        
        // Start the sequence on the sequencer inside the agent
        seq.start(env.agnt.sqr);
        
        phase.drop_objection(this);
    endtask
    
endclass
