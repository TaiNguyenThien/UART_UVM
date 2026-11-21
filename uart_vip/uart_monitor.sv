class uart_monitor extends uvm_monitor;
  `uvm_component_utils(uart_monitor)
 /* Analysis port send trans to scoreboard*/
  uvm_analysis_port #(uart_transaction) item_observed_port;
  virtual uart_if uart_vif;
  uart_configuration cfg;
  function new(string name="uart_monitor", uvm_component parent);
    super.new(name,parent);
    item_observed_port = new("item_observed_port",this);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#( uart_configuration)::get(this,"","cfg",cfg))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get uart_configuration from uvm_config_db"))
    if (!uvm_config_db#(virtual uart_if)::get(this,"","uart_vif",uart_vif))
      `uvm_fatal(get_type_name(),$sformatf("Failed to get uart_if from uvm_config_db"))
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
  /* Capture if and convert to trans level*/
   
    if (cfg.full_duplex) begin 
      fork
        monitor_tx();
	monitor_rx();
      join
    end else begin
      if (cfg.is_transmitter) 
        monitor_tx();
      else
	monitor_rx();
    end
  endtask: run_phase


  task monitor_tx();

    uart_transaction trans;
    bit [8:0] data;
    bit [1:0] parity_bit;
    bit received_parity;
 
    forever begin
      @(negedge uart_vif.tx);
      #(cfg.baud_period/2);
      data = 0;
      for ( int i = 0; i < cfg.data_bits; i++) begin
        #(cfg.baud_period);
        data[i] = uart_vif.tx   ;
      end

      if ( cfg.parity_en) begin
        #(cfg.baud_period);
        received_parity = uart_vif.tx;
      end

      if ( cfg.parity_en) begin
        parity_bit =2'b00;
        for ( int i = 0; i < cfg.data_bits; i++) begin
	  parity_bit[0] ^= data[i];
	end 
        if ( cfg.parity_mode) begin
          parity_bit[0] = ~parity_bit;
        end else begin
          parity_bit[0] = parity_bit;
        end    
        if ( received_parity !== parity_bit[0] ) begin
          `uvm_info("monitor",$sformatf("Parity mismatch! Data=0x%0h, exp = %0b, recei = %0b",data, parity_bit , received_parity),UVM_LOW)
        end
	else begin
          `uvm_info(get_type_name(),$sformatf("Parity match! Data=0x%0h, exp = %0b, recei = %0b",data, parity_bit , received_parity),UVM_LOW)
	end
      end else begin
        parity_bit = 2'b10;
        `uvm_info(get_type_name(),$sformatf("None parity"),UVM_LOW)
      end

      repeat  (cfg.stop_bit)  #(cfg.baud_period);

      trans = uart_transaction::type_id::create("trans");
      trans.data = data;
      trans.parity_bit = parity_bit;
      trans.stop_bits = cfg.stop_bit;
    
  /* Send trans to scoreboard*/
      item_observed_port.write(trans);
    end
  endtask  

  task monitor_rx();

    uart_transaction trans;
    bit [8:0] data;
    bit [1:0] parity_bit;
    bit received_parity;
 
    forever begin
      @(negedge uart_vif.rx);
      #(cfg.baud_period/2);
      data = 0;
      for ( int i = 0; i < cfg.data_bits; i++) begin
        #(cfg.baud_period);
        data[i] = uart_vif.rx   ;
      end

      if ( cfg.parity_en) begin
        #(cfg.baud_period);
        received_parity = uart_vif.rx;
      end

      if ( cfg.parity_en) begin
        parity_bit =2'b00;
        for ( int i = 0; i < cfg.data_bits; i++) begin
	  parity_bit[0] ^= data[i];
	end 
        if ( cfg.parity_mode) begin
          parity_bit[0] = ~parity_bit;
        end else begin
          parity_bit[0] = parity_bit;
        end    
        if ( received_parity !== parity_bit[0] ) begin
          `uvm_info("monitor",$sformatf("Parity mismatch! Data=0x%0h, exp = %0b, recei = %0b",data, parity_bit , received_parity), UVM_LOW)
        end
	else begin
          `uvm_info(get_type_name(),$sformatf("Parity match! Data=0x%0h, exp = %0b, recei = %0b",data, parity_bit , received_parity),UVM_LOW)
	end
      end else begin
        parity_bit = 2'b10;
        `uvm_info(get_type_name(),$sformatf("None parity"),UVM_LOW)
      end

      repeat  (cfg.stop_bit)  #(cfg.baud_period);

      trans = uart_transaction::type_id::create("trans");
      trans.data = data;
      trans.parity_bit = parity_bit;
      trans.stop_bits = cfg.stop_bit;
    
  /* Send trans to scoreboard*/
      item_observed_port.write(trans);
    end
  endtask  

endclass: uart_monitor

