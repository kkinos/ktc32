module uart_tx (
    input logic clk,
    input logic reset,
    input logic we,
    input logic [7:0] din,

    output logic dout,
    output logic busy
);

  parameter WAITCNT = 105;  // 12MHz 115.2 kbps
  localparam WAITCNTLEN = $clog2(WAITCNT);

  typedef enum {
    IDLE,
    SEND
  } state_type;

  state_type state;
  logic [WAITCNTLEN-1:0] waitcnt;
  logic [3:0] bitcnt;
  logic [9:0] data;

  assign dout = data[0];

  always_ff @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      waitcnt <= 0;
      bitcnt <= 4'b0;
      data <= 10'h3ff;
      busy <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          if (we) begin
            state <= SEND;
            data  <= {1'b1, din, 1'b0};
            busy  <= 1'b1;
          end
        end

        SEND: begin
          if (waitcnt != WAITCNT) begin
            waitcnt <= waitcnt + 1'b1;
          end else begin
            waitcnt <= 1'b0;
            bitcnt <= bitcnt + 1'b1;
            data <= {1'b1, data[9:1]};
            if (bitcnt == 4'b1001) begin
              state <= IDLE;
              waitcnt <= 0;
              bitcnt <= 4'b0;
              busy <= 1'b0;
            end
          end
        end
      endcase
    end
  end

endmodule
