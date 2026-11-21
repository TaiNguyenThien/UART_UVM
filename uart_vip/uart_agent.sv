class uart_agent extends uvm_agent;
  `uvm_component_utils(uart_agent)

  virtual uart_if vif;
  uart_configuration uart_config;

  uart_monitor   monitor;
  uart_driver    driver;
  uart_sequencer sequencer;

  function new(string name="uart_agent", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual uart_if)::get(this,"","vif", vif))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get uart_if from uvm_config_db"))
   
    if (!uvm_config_db#( uart_configuration)::get(this,"","cfg",uart_config))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get uart_config from uvm_config_db"))
   
    if (!uvm_config_db#( uvm_active_passive_enum)::get(this,"","is_active", is_active))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get uart_config from uvm_config_db"))

    if(is_active == UVM_ACTIVE) begin
      `uvm_info(get_type_name(),$sformatf("Active agent is configued"),UVM_LOW)
      driver = uart_driver::type_id::create("driver", this);
      sequencer = uart_sequencer::type_id::create("sequencer", this);
      monitor = uart_monitor::type_id::create("monitor", this);
    
      uvm_config_db#(virtual uart_if)::set(this,"driver","uart_vif", vif);
      uvm_config_db#(virtual uart_if)::set(this,"monitor","uart_vif",vif);
      
      uvm_config_db#( uart_configuration)::set(this,"driver","cfg",uart_config);
      uvm_config_db#( uart_configuration)::set(this,"monitor","cfg",uart_config);
    end
    else begin
      `uvm_info(get_type_name(),$sformatf("Passive agent is configued"),UVM_LOW)
      monitor = uart_monitor::type_id::create("monitor", this);
      
      uvm_config_db#(virtual uart_if)::set(this,"monitor","uart_vif",vif);
      
      uvm_config_db#( uart_configuration)::set(this,"monitor","cfg",uart_config);
    end

  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin 
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction: connect_phase

endclass: uart_agent
