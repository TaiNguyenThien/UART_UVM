//=============================================================================
// Project       : UART VIP
//=============================================================================
// Filename      : test_pkg.sv
// Author        : Huy Nguyen
// Company       : NO
// Date          : 20-Dec-2021
//=============================================================================
// Description   : 
//
//
//
//=============================================================================
`ifndef GUARD_UART_TEST_PKG__SV
`define GUARD_UART_TEST_PKG__SV

package test_pkg;
  import uvm_pkg::*;
  import uart_pkg::*;
  import seq_pkg::*;
  import env_pkg::*;

  // Include your file
  `include "uart_report_catcher.sv"
  `include "uart_base_test.sv"
  `include "half12_5_bits_trans_test.sv"
  `include "half12_6_bits_trans_test.sv"
  `include "half12_7_bits_trans_test.sv"
  `include "half12_8_bits_trans_test.sv"
  `include "half12_9_bits_trans_test.sv"
  
  `include "half12_4800_test.sv"
  `include "half12_9600_test.sv"
  `include "half12_19200_test.sv"
  `include "half12_57600_test.sv"
  `include "half12_115200_test.sv"
  `include "half12_baud_rate_mismatch_test.sv"

  `include "half12_none_parity_test.sv"
  `include "half12_odd_parity_test.sv"
  `include "half12_even_parity_test.sv"
  `include "half12_even_none_parity_test.sv"
  `include "half12_even_odd_parity_test.sv"
  `include "half12_odd_none_parity_test.sv"
  `include "half12_odd_even_parity_test.sv"
  `include "half12_none_odd_parity_test.sv"
  `include "half12_none_even_parity_test.sv"

  `include "half12_2_stop_bits_test.sv"
  `include "half12_1_stop_bits_test.sv"
  `include "half12_stop_bits_mismatch_test.sv"

  `include "half21_5_bits_trans_test.sv"
  `include "half21_6_bits_trans_test.sv"
  `include "half21_7_bits_trans_test.sv"
  `include "half21_8_bits_trans_test.sv"
  `include "half21_9_bits_trans_test.sv"
  
  `include "half21_4800_test.sv"
  `include "half21_9600_test.sv"
  `include "half21_19200_test.sv"
  `include "half21_57600_test.sv"
  `include "half21_115200_test.sv"
  `include "half21_baud_rate_mismatch_test.sv"

  `include "half21_none_parity_test.sv"
  `include "half21_odd_parity_test.sv"
  `include "half21_even_parity_test.sv"
  `include "half21_even_none_parity_test.sv"
  `include "half21_even_odd_parity_test.sv"
  `include "half21_odd_none_parity_test.sv"
  `include "half21_odd_even_parity_test.sv"
  `include "half21_none_odd_parity_test.sv"
  `include "half21_none_even_parity_test.sv"

  `include "half21_2_stop_bits_test.sv"
  `include "half21_1_stop_bits_test.sv"
  `include "half21_stop_bits_mismatch_test.sv"
  
  `include "full_5_bits_trans_test.sv"
  `include "full_6_bits_trans_test.sv"
  `include "full_7_bits_trans_test.sv"
  `include "full_8_bits_trans_test.sv"
  `include "full_9_bits_trans_test.sv"
  
  `include "full_4800_test.sv"
  `include "full_9600_test.sv"
  `include "full_19200_test.sv"
  `include "full_57600_test.sv"
  `include "full_115200_test.sv"
  `include "full_baud_rate_mismatch_test.sv"

  `include "full_none_parity_test.sv"
  `include "full_odd_parity_test.sv"
  `include "full_even_parity_test.sv"
  `include "full_even_none_parity_test.sv"
  `include "full_even_odd_parity_test.sv"
  `include "full_odd_none_parity_test.sv"
  `include "full_odd_even_parity_test.sv"
  `include "full_none_odd_parity_test.sv"
  `include "full_none_even_parity_test.sv"

  `include "full_2_stop_bits_test.sv"
  `include "full_1_stop_bits_test.sv"
  `include "full_stop_bits_mismatch_test.sv"
endpackage: test_pkg

`endif


