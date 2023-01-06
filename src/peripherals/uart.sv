module uart (
    input logic clk,
    input logic reset,

    input logic we,
    input logic [7:0] tx_buf,

    input logic rxd,

    output logic txd,
    output logic tx_busy,

    output logic [7:0] rx_buf,
    output logic rx_busy,
    output logic rx_valid
);

  uart_tx uart_tx (
      clk,
      reset,
      we,
      tx_buf,

      txd,
      tx_busy
  );

  uart_rx uart_rx (
      clk,
      reset,
      rxd,

      rx_buf,
      rx_busy,
      rx_valid
  );

endmodule
