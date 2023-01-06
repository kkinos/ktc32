module ktc32 (
    input logic clk,
    input logic reset,
    input logic [31:0] rd,

    output logic [ 1:0] memwrite,
    output logic [31:0] addr,
    output logic [31:0] wd
);

  logic pcen;

  logic iord;
  logic regdst;
  logic [1:0] memtoreg;
  logic [1:0] alusrca;
  logic [1:0] alusrcb;
  logic [4:0] alucontrol;
  logic pcsrc;

  logic irwrite;
  logic [2:0] regwrite;

  logic [31:0] instr;
  logic flag;

  datapath datapath (
      clk,
      reset,

      rd,

      pcen,

      iord,
      regdst,
      memtoreg,
      alusrca,
      alusrcb,
      alucontrol,
      pcsrc,

      irwrite,
      regwrite,

      instr,
      flag,
      addr,
      wd
  );

  controller controller (
      clk,
      reset,

      instr[5:0],
      flag,

      pcen,

      iord,
      regdst,
      memtoreg,
      alusrca,
      alusrcb,
      alucontrol,
      pcsrc,

      memwrite,
      irwrite,
      regwrite
  );

endmodule
