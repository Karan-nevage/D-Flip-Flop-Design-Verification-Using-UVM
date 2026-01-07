//=============================================================================================
// File: dff_sqr.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Typedef for the UVM Sequencer specialized for 'dff_tx' transactions.
//              Acts as the arbiter between sequences and the driver.
//=============================================================================================

typedef uvm_sequencer#(dff_tx) dff_sqr;
