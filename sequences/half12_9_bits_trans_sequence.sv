class half12_9_bits_trans_sequence extends uvm_sequence #(uart_transaction);
  `uvm_object_utils(half12_9_bits_trans_sequence)

  function new(string name="half12_9_bits_trans_sequence");
    super.new(name);
  endfunction

  virtual task body();
      req = uart_transaction::type_id::create("req");
      start_item(req);
      req.randomize() with {data        == 9'b011001100;
 //                           parity_en   == 1'b0;
 //                           parity_mode == 1'b0;
 //                           baud_rate   == 9600;
                            };

      `uvm_info(get_type_name(),$sformatf("Send req to driver: \n %s",req.sprint()),UVM_LOW);
      finish_item(req);
      get_response(rsp);
      `uvm_info(get_type_name(),$sformatf("Recevied rsp to driver: \n %s",rsp.sprint()),UVM_LOW);
   
      req = uart_transaction::type_id::create("req");
      start_item(req);
      req.randomize() with {data        == 9'b101010101;
 //                           parity_en   == 1'b0;
 //                           parity_mode == 1'b0;
 //                           baud_rate   == 9600;
                            };

      `uvm_info(get_type_name(),$sformatf("Send req to driver: \n %s",req.sprint()),UVM_LOW);
      finish_item(req);
      get_response(rsp);
      `uvm_info(get_type_name(),$sformatf("Recevied rsp to driver: \n %s",rsp.sprint()),UVM_LOW);
    #1us;
  endtask

endclass
