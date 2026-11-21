class uart_configuration extends uvm_object;
`uvm_object_utils(uart_configuration)


  rand bit parity_en;
  rand bit parity_mode;
  rand int baud_rate;
  rand int baud_period; // 1/baud_rate 
  rand bit [1:0] stop_bit;
  rand bit is_transmitter;
  rand bit full_duplex;
  rand int unsigned data_bits;
  constraint data_bit_c {
  data_bits >= 5;
  data_bits <= 9;
  } 
/*  `uvm_object_utils_begin (uart_configuration)
    `uvm_field_int        (parity_en                        ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (parity_mode                        ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (baud_rate                        ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (baud_period                       ,UVM_ALL_ON |UVM_HEX )
    `uvm_field_int        (stop_bit                        ,UVM_ALL_ON |UVM_HEX )
  `uvm_object_utils_end
  */
  function new(string name="uart_configuration");
    super.new(name);
  endfunction: new

endclass: uart_configuration
