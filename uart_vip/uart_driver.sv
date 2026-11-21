class uart_driver extends uvm_driver #(uart_transaction);
  `uvm_component_utils(uart_driver)

  virtual uart_if uart_vif;

  uart_configuration cfg;

  function new(string name="uart_driver", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    /** Applying the virtual interface received through the config db - learn detail in next session*/
    if (!uvm_config_db#(uart_configuration)::get(this,"","cfg",cfg))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get uart_configuration from uvm_config_db"))
    if (!uvm_config_db#(virtual uart_if)::get(this,"","uart_vif", uart_vif))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get uart_if from uvm_config_db"))
  endfunction: build_phase

  /** User can use ahb_vif to control real interface like systemverilog part*/
  virtual task run_phase(uvm_phase phase);
    forever begin 
    seq_item_port.get(req);
    uart_send(req);
    $cast(rsp,req.clone());
    rsp.set_id_info(req);
    seq_item_port.put(rsp);
    end
  endtask: run_phase

  virtual task uart_send ( inout uart_transaction req);
    bit parity_bit;
    uart_vif.tx <= 0;
    #(cfg.baud_period);
    for(int i=0; i< cfg.data_bits; i++) begin
      uart_vif.tx <= req.data[i];
      #(cfg.baud_period);
    end

    if(cfg.parity_en) begin
      parity_bit = 0;
      for(int i=0; i< cfg.data_bits; i++) begin
        parity_bit ^= req.data[i];
      end
      if(cfg.parity_mode) begin
        parity_bit = ~parity_bit;  
      end
      else begin
        parity_bit = parity_bit;  
      end
      uart_vif.tx <= parity_bit;
      #(cfg.baud_period);
    end
    
    repeat (cfg.stop_bit) begin
      uart_vif.tx <= 1;
      #(cfg.baud_period);
    end
  endtask

 
endclass: uart_driver

