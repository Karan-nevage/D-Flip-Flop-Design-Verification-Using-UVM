//=============================================================================================
// File: dff_env.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Environment class that encapsulates the agent and scoreboard.
//              Handles the creation and connection of verification components.
//=============================================================================================

class dff_env extends uvm_env;
    
    //-------------------------------------------------------------------------
    // Component Instances
    //-------------------------------------------------------------------------
    dff_sbd sbd;    // Scoreboard Instance
    dff_agnt agnt;  // Agent Instance
    
    // Factory Registration and Constructor
    `uvm_component_utils(dff_env)
    `NEW_COMP
    
    //-------------------------------------------------------------------------
    // Build Phase
    // Creates the agent and scoreboard components using the factory
    //-------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agnt = dff_agnt::type_id::create("agnt", this);
        sbd  = dff_sbd::type_id::create("sbd", this);     
    endfunction 
    
    //-------------------------------------------------------------------------
    // Connect Phase
    // Connects the Monitor's analysis port to the Scoreboard's export
    //-------------------------------------------------------------------------
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // Connecting agent's monitor port to scoreboard
        agnt.mon.ap_port.connect(sbd.ap_export);
    endfunction  
    
endclass
