module top (
    input logic clk,
    input logic n_reset,
    output logic [3:0] led
);

  logic [31:0] rd;
  logic [31:0] addr;
  logic [31:0] wd;
  logic memwrite;
  logic reset;

  assign reset = ~n_reset;

  ktc32 ktc32 (
      clk,
      reset,
      rd,
      memwrite,
      addr,
      wd
  );

  ram ram (
      clk,
      memwrite,
      addr,
      wd,
      rd,
      led
  );


endmodule
