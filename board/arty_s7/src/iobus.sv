module iobus (
    input logic clk,
    input logic reset,
    input logic [1:0] we,
    input logic [31:0] addr,
    input logic [31:0] wd,
    input logic rxd,

    output logic [31:0] data,
    output logic [3:0] led,
    output logic txd
);

  logic [7:0] ram[0:511];
  initial $readmemh("sample.mem", ram);

  logic [31:0] io_addr;

  logic led_sel;
  logic [7:0] led_data;

  logic uart_sel;
  logic [7:0] uart_tx_status;
  logic [7:0] uart_tx_data;

  logic [7:0] uart_rx_status;
  logic [7:0] uart_rx_data;



  assign io_addr  = {16'h0, addr[15:0]};
  assign led_sel  = (addr[31:16] == 16'hFFF0) ? 1 : 0;
  assign uart_sel = (addr[31:16] == 16'hFFF1) ? 1 : 0;

  always_ff @(posedge clk) begin
    case (we)
      2'b01: begin
        if (led_sel) begin
          if (io_addr == 32'h0) begin
            led_data <= wd[7:0];
          end
        end else if (uart_sel) begin
          if (io_addr == 32'h4) begin
            uart_tx_data <= wd[7:0];
          end
        end else begin
          ram[addr] <= wd[7:0];
        end
      end
      2'b10: begin
        if (led_sel) begin
          if (io_addr == 32'h0) begin
            led_data <= wd[7:0];
          end
        end else if (uart_sel) begin
          if (io_addr == 32'h4) begin
            uart_tx_data <= wd[7:0];
          end
        end else begin
          ram[addr]   <= wd[7:0];
          ram[addr+1] <= wd[15:8];
        end
      end
      2'b11: begin
        if (led_sel) begin
          if (io_addr == 32'h0) begin
            led_data <= wd[7:0];
          end
        end else if (uart_sel) begin
          if (io_addr == 32'h4) begin
            uart_tx_data <= wd[7:0];
          end
        end else begin
          ram[addr]   <= wd[7:0];
          ram[addr+1] <= wd[15:8];
          ram[addr+2] <= wd[23:16];
          ram[addr+3] <= wd[31:24];
        end
      end
      default;
    endcase
  end

  always_comb begin
    data = 32'h0;
    if (led_sel) begin
      if (io_addr == 32'h0) begin
        data = {24'h0, led_data};
      end
    end else if (uart_sel) begin
      if (io_addr == 32'h0) begin
        data = {24'h0, uart_tx_status};
      end else if (io_addr == 32'h4) begin
        data = {24'h0, uart_tx_data};
      end else if (io_addr == 32'h8) begin
        data = {24'h0, uart_rx_status};
      end else if (io_addr == 32'hc) begin
        data = {24'h0, uart_rx_data};
      end
    end else begin
      data = {ram[addr+3], ram[addr+2], ram[addr+1], ram[addr]};
    end
  end

  assign led = led_data[3:0];

  logic uart_we;
  logic [7:0] tx_buf;
  logic [7:0] rx_buf;
  logic tx_busy;
  logic rx_busy;
  logic rx_valid_p;
  logic rx_valid;

  always_ff @(posedge clk) begin
    if (rx_valid_p) begin
      rx_valid <= 1'b1;
    end else if (uart_sel && (io_addr == 32'h8)) begin
      rx_valid <= 1'b0;
    end else begin
      rx_valid <= rx_valid;
    end
  end

  always_ff @(posedge clk) begin
    if (uart_sel && (io_addr == 32'h4) && we) begin
      uart_we <= 1'b1;
    end else begin
      uart_we <= 1'b0;
    end
  end

  always_ff @(posedge clk) begin
    uart_tx_status <= {7'b0, tx_busy};
    uart_rx_status <= {6'b0, rx_valid, rx_busy};
  end

  assign tx_buf = uart_tx_data;
  assign uart_rx_data = rx_buf;

  uart uart (
      clk,
      reset,

      uart_we,
      tx_buf,

      rxd,

      txd,
      tx_busy,

      rx_buf,
      rx_busy,
      rx_valid_p
  );

endmodule
