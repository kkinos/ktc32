module top (
    input logic clk,
    input logic n_reset,

    output logic [3:0] led,
    output logic txd
);

  logic [31:0] rd;
  logic [31:0] addr;
  logic [31:0] wd;
  logic [1:0] memwrite;
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
      reset,
      memwrite,
      addr,
      wd,

      rd,
      led,
      txd
  );

endmodule
