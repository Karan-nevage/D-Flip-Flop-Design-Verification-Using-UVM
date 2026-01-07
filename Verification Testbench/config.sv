//=============================================================================================
// File: config.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Contains common macros and global variables used across the testbench.
//=============================================================================================

//-----------------------------------------------------------------------------
// Macros for Constructor Definitions
//-----------------------------------------------------------------------------

// Macro for UVM Object constructor (Sequence items, Config objects)
`define NEW_OBJ \
    function new(string name = ""); \
        super.new(name); \
    endfunction

// Macro for UVM Component constructor (Driver, Monitor, Agent, etc.)
`define NEW_COMP \
    function new(string name = "", uvm_component parent); \
        super.new(name, parent); \
    endfunction

//-----------------------------------------------------------------------------
// Global Variables
//-----------------------------------------------------------------------------
int match;
int missmatch;
