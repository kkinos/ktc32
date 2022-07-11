module controller (
    input logic clk,
    input logic reset,

    input logic [5:0] opcode,
    input logic zero,

    output logic pcen,
    
    output logic memtoreg,
    output logic iord,
    output logic pcsrc,
    output logic alusrca,
    output logic [1:0] alusrcb,
    output logic [2:0] alucontrol,

    output logic memwrite,
    output logic irwrite,
    output logic regwrite
);

  logic branch;
  logic pcwrite;

  maindec maindec (
      clk,
      reset,
      opcode,
      memtoreg,
      iord,
      pcsrc,
      alusrca,
      alusrcb,
      alucontrol,
      irwrite,
      memwrite,
      pcwrite,
      branch,
      regwrite
  );

  always_comb begin
    pcen = pcwrite | (branch & zero);
  end


endmodule
