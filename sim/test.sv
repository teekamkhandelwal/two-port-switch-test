`include "environment.sv"
// Test class instantiates the environment and starts it.
program test(switch_if vif);
  environment env;
  
  initial begin
    env=new(vif);
    env.run();
    end
endprogram
