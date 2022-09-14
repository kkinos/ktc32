module top (
    input logic clk,
    input logic reset,
    output logic [3:0] led
);

  logic [31:0] rd;
  logic [31:0] addr;
  logic [31:0] wd;
  logic memwrite;

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
      rd
  );

  always_ff @(posedge clk) begin
    if (memwrite && (addr == 16'h54)) begin
      led <= wd[3:0];
    end else begin
      led <= led;
    end
  end

endmodule
