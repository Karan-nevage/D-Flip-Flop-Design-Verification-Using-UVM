//=============================================================================================
// File: dff_tx.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Defines the sequence item (transaction) for the DFF.
//              Contains randomizable input signals, output signals, and constraints.
//=============================================================================================

class dff_tx extends uvm_sequence_item;

    // Randomizable Inputs
    rand logic d;
    rand logic rst;
    
    // Output Signal
    logic q; 
    
    // Factory Registration and Field Macros
    `uvm_object_utils_begin(dff_tx)
        `uvm_field_int(rst, UVM_ALL_ON)
        `uvm_field_int(d,   UVM_ALL_ON)
        `uvm_field_int(q,   UVM_ALL_ON)
    `uvm_object_utils_end

    // Constructor
    function new(string name = "dff_tx");
        super.new(name);
    endfunction 

    // Constraints
    constraint rst_not_asserted {
        soft rst != 1;
    }
    
endclass
