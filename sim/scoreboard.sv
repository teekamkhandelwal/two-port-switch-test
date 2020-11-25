// The scoreboard is responsible to check data integrity. Since
// the design routes packets based on an address range, the
// scoreboard checks that the packet's address is within valid
// range.
class scoreboard;
  mailbox scb_mbx;
    
  function new (mailbox scb_mbx);
    this.scb_mbx=scb_mbx;
  endfunction
  task run();
    forever begin
      switch_item item;
      scb_mbx.get(item);
      
      if (item.addr inside {[0:'h3f]}) begin
        if (item.addr_a != item.addr | item.data_a != item.data) begin
          $display("---------------------------------------------------------------------------------");
          $display ("T=%0t [Scoreboard] ERROR! Mismatch addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h", $time, item.addr, item.data, item.addr_a, item.data_a);
          $display("---------------------------------------------------------------------------------");
        end
        else begin
          $display("---------------------------------------------------------------------------------");
          $display ("T=%0t [Scoreboard] PASS! Match addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h", $time, item.addr, item.data, item.addr_a, item.data_a);
          $display("---------------------------------------------------------------------------------");
        end
      
      end else begin
        if (item.addr_b != item.addr | item.data_b != item.data) begin
          $display("---------------------------------------------------------------------------------");
          $display ("T=%0t [Scoreboard] ERROR! Mismatch addr=0x%0h data=0x%0h addr_b=0x%0h data_b=0x%0h", $time, item.addr, item.data, item.addr_b, item.data_b);
          $display("---------------------------------------------------------------------------------");
        end
        else begin
          $display("---------------------------------------------------------------------------------");
          $display ("T=%0t [Scoreboard] PASS! Match addr=0x%0h data=0x%0h addr_b=0x%0h data_b=0x%0h", $time, item.addr, item.data, item.addr_b, item.data_b);
          $display("---------------------------------------------------------------------------------");
        end
      end
    end
  endtask
endclass
