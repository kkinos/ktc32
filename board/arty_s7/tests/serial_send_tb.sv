`timescale 1ns / 1ns

module serial_send_tb;

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

  initial $readmemh("../program/serial_send.mem", top.ram.mem);

  initial begin
    $dumpfile("serial_send_tb.vcd");
    $dumpvars(0, serial_send_tb);
  end

endmodule
