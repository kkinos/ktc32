module ram (
    input logic clk,
    input logic reset,
    input logic [1:0] we,
    input logic [31:0] addr,
    input logic [31:0] wd,

    output logic [31:0] data,
    output logic [3:0] led,
    output logic txd
);

  logic [7:0] mem[0:511];

  logic led_sel;
  logic [7:0] led_data;

  logic uart_sel;
  logic [7:0] uart_tx_start;
  logic [7:0] uart_tx_status;
  logic [7:0] uart_tx_data;

  logic [31:0] io_addr;

  initial $readmemh("led_loop.mem", mem);

  assign led_sel  = (addr[31:16] == 16'hFFF0) ? 1 : 0;
  assign uart_sel = (addr[31:16] == 16'hFFF1) ? 1 : 0;
  assign io_addr  = {16'h0, addr[15:0]};

  always_ff @(posedge clk) begin
    case (we)
      2'b01: begin
        if (led_sel) begin
          if (io_addr == 32'h0) begin
            led_data <= wd[7:0];
          end
        end else if (uart_sel) begin
          if (io_addr == 32'h0) begin
            uart_tx_start <= wd[7:0];
          end else if (io_addr == 32'h8) begin
            uart_tx_data <= wd[7:0];
          end
        end else begin
          mem[addr] <= wd[7:0];
        end
      end
      2'b10: begin
        if (led_sel) begin
          if (io_addr == 32'h0) begin
            led_data <= wd[7:0];
          end
        end else if (uart_sel) begin
          if (io_addr == 32'h0) begin
            uart_tx_start <= wd[7:0];
          end else if (io_addr == 32'h8) begin
            uart_tx_data <= wd[7:0];
          end
        end else begin
          mem[addr]   <= wd[7:0];
          mem[addr+1] <= wd[15:8];
        end
      end
      2'b11: begin
        if (led_sel) begin
          if (io_addr == 32'h0) begin
            led_data <= wd[7:0];
          end
        end else if (uart_sel) begin
          if (io_addr == 32'h0) begin
            uart_tx_start <= wd[7:0];
          end else if (io_addr == 32'h8) begin
            uart_tx_data <= wd[7:0];
          end
        end else begin
          mem[addr]   <= wd[7:0];
          mem[addr+1] <= wd[15:8];
          mem[addr+2] <= wd[23:16];
          mem[addr+3] <= wd[31:24];
        end
      end
      default;
    endcase
  end

  always_comb begin
    if (led_sel) begin
      if (io_addr == 32'h0) begin
        data = {24'h0, led_data};
      end
    end else if (uart_sel) begin
      if (io_addr == 32'h0) begin
        data = {24'h0, uart_tx_start};
      end else if (io_addr == 32'h4) begin
        data = {24'h0, uart_tx_status};
      end else if (io_addr == 32'h8) begin
        data = {24'h0, uart_tx_data};
      end
    end else begin
      data = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
    end
  end

  assign led = led_data[3:0];

  logic we_uart;
  logic [7:0] din;
  logic busy;

  always_ff @(posedge clk) begin
    uart_tx_status <= {7'b0, busy};
  end

  assign we_uart = uart_tx_start[0];
  assign din = uart_tx_data;

  uart_tx uart_tx (
      clk,
      reset,
      we_uart,
      din,

      txd,
      busy
  );

endmodule
