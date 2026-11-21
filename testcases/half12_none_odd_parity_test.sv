class half12_none_odd_parity_test extends uart_base_test;
  `uvm_component_utils(half12_none_odd_parity_test)

  half12_parity_mismatch_sequence half12_parity_mismatch_seq;

  function new(string name="half12_none_odd_parity_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new
 
  virtual function void build_phase(uvm_phase phase);
    uart_configuration config_lhs, config_rhs;
    super.build_phase(phase);

    config_lhs = uart_configuration::type_id::create("config_lhs",this);
    config_lhs.parity_en      = 0;
    config_lhs.parity_mode    = 0;
    config_lhs.baud_rate      = 9600;
    config_lhs.baud_period    = 104;
    config_lhs.stop_bit       = 1;
    config_lhs.is_transmitter = 1;
    config_lhs.data_bits      = 5;

    config_rhs = uart_configuration::type_id::create("config_rhs",this);
    config_rhs.parity_en      = 1;
    config_rhs.parity_mode    = 1;
    config_rhs.baud_rate      = 9600;
    config_rhs.baud_period    = 104;
    config_rhs.stop_bit       = 1;
    config_rhs.is_transmitter = 0;
    config_rhs.data_bits      = 5;
      
    uvm_config_db#(uart_configuration)::set(this, "uart_env","cfg_lhs", config_lhs);
    uvm_config_db#(uart_configuration)::set(this, "uart_env","cfg_rhs", config_rhs);

    uvm_config_db#(uvm_active_passive_enum)::set(this, "uart_env.agt_rhs","is_active", UVM_PASSIVE);
    uvm_config_db#(uvm_active_passive_enum)::set(this, "uart_env.agt_lhs","is_active", UVM_ACTIVE);

  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    rpt_catcher.add_error_catcher_msg("Data intergity MISMATCH");
    rpt_catcher.add_error_catcher_msg("Parity_rhs and Parity_lhs MISMATCH");
    rpt_catcher.add_error_catcher_msg("Stop_bits_rhs and Stop_bits_lhs MISMATCH");
    half12_parity_mismatch_seq = half12_parity_mismatch_sequence::type_id::create("half12_parity_mismatch_seq");
    half12_parity_mismatch_seq.start(uart_env.agt_lhs.sequencer);
    #1000000000;
    phase.drop_objection(this);
  endtask

endclass

