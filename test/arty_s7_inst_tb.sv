`timescale 1ns / 1ns

module arty_s7_inst_tb;

  logic clk, reset;
  logic [3:0] led;

  parameter STEP = 10;

  always begin
    clk = 0;
    #STEP;
    clk = 1;
    #STEP;
  end

  initial begin
    reset = 1;
    #STEP reset = 0;
    #STEP reset = 1;
    #(STEP * 400) $finish;
  end

  top top (
      clk,
      reset,
      led
  );

  initial $readmemh("../program/arty_s7/inst/program.mem", top.ram.mem);

  initial begin
    $dumpfile("arty_s7_inst_tb.vcd");
    $dumpvars(0, arty_s7_inst_tb);
  end

endmodule
