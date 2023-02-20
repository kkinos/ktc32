module uart_rx (
    input logic clk,
    input logic reset,
    input logic din,

    output logic [7:0] dout,
    output logic busy,
    output logic valid
);

  parameter WAITCNT = 1260;  // 12MHz 9600bps
  parameter HALFWAITCNT = 630;
  localparam WAITCNTLEN = $clog2(WAITCNT);

  typedef enum {
    IDLE,
    WAIT,
    READ
  } state_type;

  state_type state;
  logic [WAITCNTLEN-1:0] waitcnt;
  logic [3:0] bitcnt;
  logic [8:0] data;
  logic [3:0] startedge;

  assign busy = (state != IDLE);

  always_ff @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      waitcnt <= 0;
      bitcnt <= 4'b0;
      data <= 9'b0;
      startedge <= 4'b1111;
      valid <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          startedge <= {startedge[2:0], din};
          valid <= 1'b0;
          if (startedge == 4'b1000) begin
            state   <= WAIT;
            waitcnt <= 0;
          end
        end
        WAIT: begin
          if (waitcnt != HALFWAITCNT) begin
            waitcnt <= waitcnt + 1'b1;
          end else begin
            state   <= READ;
            waitcnt <= 0;
          end
        end
        READ: begin
          if (waitcnt != WAITCNT) begin
            waitcnt <= waitcnt + 1'b1;
          end else begin
            waitcnt <= 0;
            bitcnt <= bitcnt + 1'b1;
            data <= {din, data[8:1]};
          end
          if (bitcnt == 4'b1001) begin
            if (data[8]) begin
              dout <= data[7:0];
            end
            state <= IDLE;
            waitcnt <= 0;
            bitcnt <= 4'b0;
            data <= 9'b0;
            startedge <= 4'b1111;
            valid <= 1'b1;
          end
        end
      endcase
    end
  end

endmodule
