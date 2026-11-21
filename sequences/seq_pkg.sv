//=============================================================================
// Project       : UART VIP
//=============================================================================
// Filename      : seq_pkg.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 20-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_UART_SEQ_PKG__SV
`define GUARD_UART_SEQ_PKG__SV

package seq_pkg;
  import uvm_pkg::*;
  import uart_pkg::*;
  `include "half12_5_bits_trans_sequence.sv"
  `include "half12_6_bits_trans_sequence.sv"
  `include "half12_7_bits_trans_sequence.sv"
  `include "half12_8_bits_trans_sequence.sv"
  `include "half12_9_bits_trans_sequence.sv"

  `include "half12_4800_sequence.sv"
  `include "half12_baud_rate_mismatch_sequence.sv"
  
  `include "half12_parity_mismatch_sequence.sv"
endpackage: seq_pkg

`endif


