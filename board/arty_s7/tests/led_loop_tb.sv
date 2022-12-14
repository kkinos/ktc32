`timescale 1ns / 1ns

module led_loop_tb;

  logic clk, reset;
  logic [3:0] led;
  logic txd;

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
    #(STEP * 4) reset = 1;
    #(STEP * 500000) $finish;
  end

  top top (
      clk,
      reset,
      led,
      txd
  );

  initial $readmemh("../program/led_loop.mem", top.iobus.ram);

  initial begin
    $dumpfile("led_loop_tb.vcd");
    $dumpvars(0, led_loop_tb);
  end

endmodule
