class uart_transaction extends uvm_sequence_item;


  rand bit [8:0] data;
  rand bit [1:0] parity_bit;
  rand bit [1:0] stop_bits;
//  rand bit parity_mode;
//  rand int baud_rate;
  rand int unsigned data_bits;
  constraint data_bit_c {
  data_bits >= 5;
  data_bits <= 9;
  } 

  `uvm_object_utils_begin (uart_transaction)
    `uvm_field_int        (data                        ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (parity_bit                        ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (stop_bits                        ,UVM_ALL_ON |UVM_HEX )
//    `uvm_field_int        (baud_rate                        ,UVM_ALL_ON |UVM_HEX )
    `uvm_object_utils_end

  function new(string name="uart_transaction");
    super.new(name);
  endfunction: new

endclass: uart_transaction
