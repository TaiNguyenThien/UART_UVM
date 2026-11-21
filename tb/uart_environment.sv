class uart_environment extends uvm_env;
  `uvm_component_utils(uart_environment)
  virtual uart_if lhs_vif;
  virtual uart_if rhs_vif;
  uart_configuration config_lhs, config_rhs;

  uart_agent  agt_lhs, agt_rhs;
  uart_scoreboard     uart_sb;

  function new(string name="uart_environment", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase","Entered...",UVM_HIGH)
    
    if (!uvm_config_db#(virtual uart_if)::get(this,"","lhs_vif",lhs_vif))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get lhs_if from uvm_config_db"))
    if (!uvm_config_db#(virtual uart_if)::get(this,"","rhs_vif",rhs_vif))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get rhs_if from uvm_config_db"))

    if (!uvm_config_db#(uart_configuration)::get(this,"","cfg_lhs",config_lhs))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get config_lhs from uvm_config_db"))
    if (!uvm_config_db#(uart_configuration)::get(this,"","cfg_rhs",config_rhs))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get config_rhs from uvm_config_db"))

    agt_lhs      = uart_agent::type_id::create("agt_lhs", this);
    agt_rhs      = uart_agent::type_id::create("agt_rhs", this);
    uart_sb      = uart_scoreboard::type_id::create("uart_sb", this);
    
    uvm_config_db#(virtual uart_if)::set(this,"agt_lhs","vif",lhs_vif);
    uvm_config_db#(virtual uart_if)::set(this,"agt_rhs","vif",rhs_vif);

    uvm_config_db#(uart_configuration)::set(this,"agt_lhs","cfg",config_lhs);
    uvm_config_db#(uart_configuration)::set(this,"agt_rhs","cfg",config_rhs);

    `uvm_info("build_phase","Exiting...",UVM_HIGH)
  endfunction: build_phase
 
  virtual function void connect_phase ( uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("connect_phase","Entered...",UVM_HIGH)

    /* Connect to sb */
    agt_lhs.monitor.item_observed_port.connect(uart_sb.item_collected_export_lhs);
    agt_rhs.monitor.item_observed_port.connect(uart_sb.item_collected_export_rhs);

    `uvm_info("connect_phase","Exiting...",UVM_HIGH)
  endfunction: connect_phase

endclass: uart_environment
