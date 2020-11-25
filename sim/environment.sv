`include "switch_item.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

// The environment is a container object simply to hold 
// all verification  components together. This environment can
// then be reused later and all components in it would be
// automatically connected and available for use
class environment;
  
  driver d0; 		// Driver handle
  monitor m0; 		// Monitor handle
  generator g0; 		// Generator Handle
  scoreboard s0; 		// Scoreboard handle
  
  mailbox 	drv_mbx; 		// Connect GEN -> DRV
  mailbox 	scb_mbx; 		// Connect MON -> SCB
  event 	drv_done; 		// Indicates when driver is done
  
  virtual switch_if vif; 	// Virtual interface handle
  
  function new (virtual switch_if vif);
    this.vif=vif;
    drv_mbx = new();
    scb_mbx = new();
    d0 = new(drv_mbx,vif,drv_done);
    m0 = new(vif,scb_mbx);
    g0 = new(drv_mbx,drv_done);
    s0 = new(scb_mbx);
    
    
  /*  d0.drv_mbx = drv_mbx;
    g0.drv_mbx = drv_mbx;
    m0.scb_mbx = scb_mbx;
    s0.scb_mbx = scb_mbx;
    
    d0.drv_done = drv_done;
    g0.drv_done = drv_done;*/
  endfunction
  
   task run();
    
    fork
      d0.run();
      m0.run();
      g0.run();
      s0.run();
    join_any
     $finish;
  endtask
endclass

