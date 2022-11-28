module ram (
    input logic clk,
    input logic [1:0] we,
    input logic [31:0] addr,
    input logic [31:0] wd,
    output logic [31:0] data,
    output logic [3:0] led
);

  logic [7:0] mem[0:512];
  logic [7:0] io[0:31];
  logic io_sel;
  logic [31:0] io_addr;

  initial $readmemh("led_loop.mem", mem);

  assign io_sel  = (addr[31:20] == 12'hFFF) ? 1 : 0;
  assign io_addr = {12'h0, addr[19:0]};


  always_ff @(posedge clk) begin
    case (we)
      2'b01: begin
        if (io_sel) begin
          io[io_addr] <= wd[7:0];
        end else begin
          mem[addr] <= wd[7:0];
        end
      end
      2'b10: begin
        if (io_sel) begin
          io[io_addr]   <= wd[7:0];
          io[io_addr+1] <= wd[15:8];
        end else begin
          mem[addr]   <= wd[7:0];
          mem[addr+1] <= wd[15:8];
        end
      end
      2'b11: begin
        if (io_sel) begin
          io[io_addr]   <= wd[7:0];
          io[io_addr+1] <= wd[15:8];
          io[io_addr+2] <= wd[23:16];
          io[io_addr+3] <= wd[31:24];
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
    if (io_sel) begin
      data = {io[io_addr+3], io[io_addr+2], io[io_addr+1], io[io_addr]};
    end else begin
      data = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
    end
  end

  assign led = io[0][3:0];

endmodule
