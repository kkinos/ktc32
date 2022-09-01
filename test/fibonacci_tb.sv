`timescale 1ns / 1ns

module fibonacci_tb;

  logic clk, reset;
  logic [31:0] rd;

  logic [15:0] addr;
  logic [15:0] wd;
  logic memwrite;

  parameter STEP = 10;

  always begin
    clk = 0;
    #STEP;
    clk = 1;
    #STEP;
  end

  initial begin
    reset = 0;
    #STEP reset = 1;
    #STEP reset = 0;
  end

  ktc16 ktc16 (
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

  initial $readmemh("fibonacci.mem", ram.mem);

  always @(negedge clk) begin
    if (memwrite) begin
      if (wd == 144 && addr == 80) begin
        $display("=== fibonacci succeeded ===");
        $finish;
      end else begin
        $display("=== fibonacci failed ===");
        $finish;
      end
    end
  end

  initial begin
    $dumpfile("fibonacci_tb.vcd");
    $dumpvars(0, fibonacci_tb);
  end

endmodule
