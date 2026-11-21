class uart_report_catcher extends uvm_report_catcher;
  `uvm_object_utils(uart_report_catcher)

  string error_msg_q[$];

  function new(string name="uart_report_catcher");
    super.new(name);
  endfunction

   function uvm_report_catcher::action_e catch();
    string str_cmp;

    if(get_severity() == UVM_ERROR) begin
      foreach(error_msg_q[i]) begin
	str_cmp = error_msg_q[i];
	if(get_message() == str_cmp) begin
          set_severity(UVM_INFO);
          `uvm_info("REPORT_CATCHER", $sformatf("Demoted below error message: %s", str_cmp), UVM_NONE)
	end
      end
    end
    return THROW;

  endfunction
  
  virtual function void add_error_catcher_msg(string str);
    error_msg_q.push_back(str);
  endfunction

endclass

