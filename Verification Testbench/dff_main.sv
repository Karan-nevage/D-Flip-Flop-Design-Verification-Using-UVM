//=============================================================================================
// File: main.sv
// Author: karankumar nevage | karanpr9423@gmail.com
// Description: Defines the AXI interface for connecting the DUT to the UVM testbench.
//              Includes signal declarations and clocking blocks for driver, monitor, and responder.
//=============================================================================================

import uvm_pkg::*;
`include "uvm_macros.svh"

// Configuration and Interface
`include "config.sv"
`include "dff_intf.sv"

// Sequence Item and Sequences
`include "dff_tx.sv"
`include "dff_seq_lib.sv"

// Agent Components
`include "dff_sqr.sv"
`include "dff_drv.sv"
`include "dff_mon.sv"
`include "dff_agnt.sv"

// Environment and Scoreboard
`include "dff_sbd.sv"
`include "dff_env.sv"

// Test and Top
`include "dff_test_lib.sv"
`include "top.sv"