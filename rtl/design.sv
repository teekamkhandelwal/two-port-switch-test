//////////////////////////////////////////////////////////////////////////////////
// Company: nit kurukshetra
// Engineer: teekam chand khandelwal
// 
// Create Date:    13:42:10 11/25/2020 
// Design Name: 
// Module Name:    switch
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module switch 
  # (parameter ADDR_WIDTH = 8,
     parameter DATA_WIDTH = 16,
     parameter ADDR_DIV = 8'h3F
    )
  
  ( input clk,
   	input rstn,
    input vld,
    
    input [ADDR_WIDTH-1:0] 	addr,
   input [DATA_WIDTH-1:0] 	data,
   
   output reg [ADDR_WIDTH-1:0] 	addr_a,
   output reg [DATA_WIDTH-1:0] 	data_a,

   output reg [ADDR_WIDTH-1:0] 	addr_b,
   output reg [DATA_WIDTH-1:0] 	data_b
  );
  
  always @ (posedge clk) begin
    if (!rstn) begin
      	addr_a <= 0;
    	data_a <= 0;
    	addr_b <= 0;
    	data_b <= 0;
    end else begin
      if (vld) begin
      	if (addr >= 0 & addr <= ADDR_DIV) begin
        	addr_a <= addr;
      		data_a <= data;
          	addr_b <= 0;
          	data_b <= 0;
      	end else begin
          	addr_a <= 0;
          	data_a <= 0;
        	addr_b <= addr;
        	data_b <= data;
      	end
      end
    end
  end
endmodule
