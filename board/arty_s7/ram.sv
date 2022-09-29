module ram (
    input logic clk,
    input logic we,
    input logic [31:0] addr,
    input logic [31:0] wd,
    output logic [31:0] data,
    output logic [3:0] led
);

  logic [7:0] mem[0:1024];
  logic [7:0] io[0:31];
  logic mem_sel;
  logic io_sel;
  logic [31:0] ram_addr;

  initial $readmemh("program.mem", mem);

  assign mem_sel  = (addr[31:20] == 12'h000) ? 1 : 0;
  assign io_sel   = (addr[31:20] == 12'hFFF) ? 1 : 0;
  assign ram_addr = {12'h0, addr[19:0]};


  always_ff @(posedge clk) begin
    if (mem_sel && we) begin
      mem[ram_addr]   <= wd[7:0];
      mem[ram_addr+1] <= wd[15:8];
      mem[ram_addr+2] <= wd[23:16];
      mem[ram_addr+3] <= wd[31:24];
    end else if (io_sel && we) begin
      io[ram_addr]   <= wd[7:0];
      io[ram_addr+1] <= wd[15:8];
      io[ram_addr+2] <= wd[23:16];
      io[ram_addr+3] <= wd[31:24];
    end
  end

  assign data = (mem_sel) ? {mem[ram_addr+3], mem[ram_addr+2], mem[ram_addr+1], mem[ram_addr]} : 32'h0;

  assign led = io[0][3:0];

endmodule
