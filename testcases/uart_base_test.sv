class uart_base_test extends uvm_test;
  `uvm_component_utils(uart_base_test)
  virtual uart_if lhs_vif;
  virtual uart_if rhs_vif;
  uart_environment uart_env;
  uart_report_catcher  rpt_catcher;

  function new(string name="uart_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual uart_if)::get(this,"","lhs_vif",lhs_vif))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get lhs_vif from uvm_config_db"))
    if (!uvm_config_db#(virtual uart_if)::get(this,"","rhs_vif",rhs_vif))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get rhs_vif from uvm_config_db"))

    `uvm_info("build_phase","Entered...",UVM_HIGH)

    uart_env = uart_environment::type_id::create("uart_env",this);
    
    rpt_catcher = uart_report_catcher::type_id::create("rpt_catcher");
    uvm_report_cb::add(null, rpt_catcher);

    uvm_config_db#(virtual uart_if)::set(this,"uart_env","lhs_vif",lhs_vif);
    uvm_config_db#(virtual uart_if)::set(this,"uart_env","rhs_vif",rhs_vif);
    

    `uvm_info("build_phase","Exiting...",UVM_HIGH)
  endfunction: build_phase
  
  virtual function void start_of_simulation_phase(uvm_phase phase);

    `uvm_info("start_of_simulation_phase","Entered...",UVM_HIGH)
    uvm_top.print_topology();
    `uvm_info("start_of_simulation_phase","Exiting...",UVM_HIGH)
  endfunction

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);

   // int error_cnt = uvm_report_server::get_server().get_severity_count(UVM_ERROR);
    if(uvm_report_server::get_server().get_severity_count(UVM_ERROR) == 0 ) begin
      `uvm_info(get_type_name(),"TEST PASSED", UVM_NONE)
    end
    else begin
    
      `uvm_info(get_type_name(),"TEST FAILED", UVM_NONE)
    end
  endfunction: report_phase

endclass

