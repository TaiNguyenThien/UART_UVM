`uvm_analysis_imp_decl(_lhs)
`uvm_analysis_imp_decl(_rhs)

class uart_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(uart_scoreboard)
/* Analysis port received trans from monitor*/
  uvm_analysis_imp_lhs#(uart_transaction, uart_scoreboard) item_collected_export_lhs;

  uvm_analysis_imp_rhs#(uart_transaction, uart_scoreboard) item_collected_export_rhs;
 
  uart_transaction lhs_q[$];
  uart_transaction rhs_q[$];
  function new(string name="uart_scoreboard", uvm_component parent);
    super.new(name,parent);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase","Entered...",UVM_HIGH)
    item_collected_export_lhs = new ("item_collected_export_lhs",this);
    item_collected_export_rhs = new ("item_collected_export_rhs",this);
    `uvm_info("build_phase","Exited...",UVM_HIGH)
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
  endtask: run_phase

  virtual function void write_lhs(uart_transaction trans);

    `uvm_info(get_type_name(),$sformatf("[scoreboard] [write_lhs] Get data from LHS \n %s",trans.sprint()),UVM_LOW);
    if(rhs_q.size() > 0 ) begin
      uart_transaction rhs_trans = rhs_q.pop_front();
      if ( rhs_trans.data === trans.data ) begin 
        `uvm_info(get_type_name(),$sformatf("[scoreboard] [write_lhs] Data intergity MATCH") ,UVM_LOW);
      end   
      else begin	      
        `uvm_error(get_type_name(),$sformatf("Data intergity MISMATCH"));
      end
      
      if ( rhs_trans.parity_bit === trans.parity_bit ) begin 
        `uvm_info(get_type_name(),$sformatf("[scoreboard] [write_rhs] Parity_rhs and Parity_lhs : MATCH") ,UVM_LOW);
      end
      else begin	      
        `uvm_error(get_type_name(),$sformatf("Parity_rhs and Parity_lhs MISMATCH"));
      end
     
      if ( rhs_trans.stop_bits === trans.stop_bits ) begin 
        `uvm_info(get_type_name(),$sformatf("[scoreboard] [write_rhs] Stop_bits_rhs and Stop_bits_lhs : MATCH") ,UVM_LOW);
      end
      else begin	      
        `uvm_error(get_type_name(),$sformatf("Stop_bits_rhs and Stop_bits_lhs MISMATCH"));
      end
    end
    else begin
      lhs_q.push_back(trans);
    end
  endfunction: write_lhs

  virtual function void write_rhs(uart_transaction trans);

    `uvm_info(get_type_name(),$sformatf("[scoreboard] [write_rhs] Get data from RHS \n %s",trans.sprint()),UVM_LOW);
    if(lhs_q.size() > 0 ) begin
      uart_transaction lhs_trans = lhs_q.pop_front();
      if ( lhs_trans.data === trans.data ) begin 
        `uvm_info(get_type_name(),$sformatf("[scoreboard] [write_rhs] Data intergity MATCH") ,UVM_LOW);
      end
      else begin	      
        `uvm_error(get_type_name(),$sformatf("Data intergity MISMATCH"));
      end

      if ( lhs_trans.parity_bit === trans.parity_bit ) begin 
        `uvm_info(get_type_name(),$sformatf("[scoreboard] [write_rhs] Parity_lhs and Parity_rhs : MATCH") ,UVM_LOW);
      end
      else begin	      
        `uvm_error(get_type_name(),$sformatf("Parity_rhs and Parity_lhs MISMATCH"));
      end
      if ( lhs_trans.stop_bits === trans.stop_bits ) begin 
        `uvm_info(get_type_name(),$sformatf("[scoreboard] [write_rhs] Stop_bits_lhs and Stop_bits_rhs : MATCH") ,UVM_LOW);
      end
      else begin	      
        `uvm_error(get_type_name(),$sformatf("Stop_bits_rhs and Stop_bits_lhs MISMATCH"));
      end
    end
    else begin
      rhs_q.push_back(trans);
    end
  endfunction: write_rhs

endclass: uart_scoreboard
