class half21_6_bits_trans_test extends uart_base_test;
  `uvm_component_utils(half21_6_bits_trans_test)

  half12_6_bits_trans_sequence half12_6_bits_seq;

  function new(string name="half21_6_bits_trans_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new
 
  virtual function void build_phase(uvm_phase phase);
    uart_configuration config_lhs, config_rhs;
    super.build_phase(phase);

    config_lhs = uart_configuration::type_id::create("config_lhs",this);
    config_lhs.parity_en   = 0;
    config_lhs.baud_rate   = 9600;
    config_lhs.baud_period = 104;
    config_lhs.stop_bit    = 1;
    config_lhs.is_transmitter = 0;
    config_lhs.data_bits   = 6;

    config_rhs = uart_configuration::type_id::create("config_rhs",this);
    config_rhs.parity_en   = 0;
    config_rhs.baud_rate   = 9600;
    config_rhs.baud_period = 104;
    config_rhs.stop_bit    = 1;
    config_rhs.is_transmitter = 1;
    config_rhs.data_bits   = 6;
      
    uvm_config_db#(uart_configuration)::set(this, "uart_env","cfg_lhs", config_lhs);
    uvm_config_db#(uart_configuration)::set(this, "uart_env","cfg_rhs", config_rhs);
    
    uvm_config_db#(uvm_active_passive_enum)::set(this, "uart_env.agt_lhs","is_active", UVM_PASSIVE);
    uvm_config_db#(uvm_active_passive_enum)::set(this, "uart_env.agt_rhs","is_active", UVM_ACTIVE);
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    half12_6_bits_seq = half12_6_bits_trans_sequence::type_id::create("half12_6_bits_seq");
    half12_6_bits_seq.start(uart_env.agt_rhs.sequencer);
    #1000000000;
    phase.drop_objection(this);
  endtask

endclass

