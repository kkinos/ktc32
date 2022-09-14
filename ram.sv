module ram (
    input logic clk,
    input logic we,
    input logic [31:0] addr,
    input logic [31:0] wd,
    output logic [31:0] data
);

  logic [7:0] mem[0:1024];
  initial $readmemh("program.mem", mem);

  always_ff @(posedge clk) begin
    if (we) begin
      mem[addr]   <= wd[7:0];
      mem[addr+1] <= wd[15:8];
      mem[addr+2] <= wd[23:16];
      mem[addr+3] <= wd[31:24];
    end
  end

  assign data = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};

endmodule
