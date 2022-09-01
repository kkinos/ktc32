module ktc16 (
    input logic clk,
    input logic reset,
    input logic [31:0] rd,

    output logic memwrite,
    output logic [15:0] addr,
    output logic [15:0] wd
);

  logic pcen;
  logic iord;
  logic irwrite;
  logic memtoreg;
  logic regwrite;
  logic alusrca;
  logic [1:0] alusrcb;
  logic [2:0] alucontrol;
  logic pcsrc;
  logic [31:0] instr;
  logic zero;

  datapath datapath (
      clk,
      reset,

      rd,
      pcen,

      iord,
      irwrite,
      memtoreg,
      regwrite,
      alusrca,
      alusrcb,
      alucontrol,
      pcsrc,

      instr,
      zero,
      addr,
      wd
  );

  controller controller (
      clk,
      reset,

      instr[5:0],
      zero,

      pcen,

      memtoreg,
      iord,
      pcsrc,
      alusrca,
      alusrcb,
      alucontrol,

      memwrite,
      irwrite,
      regwrite
  );

endmodule
