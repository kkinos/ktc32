module datapath (
    input logic clk,
    input logic reset,

    input logic [31:0] rd,

    input logic pcen,

    input logic iord,
    input logic regdst,
    input logic [1:0] memtoreg,
    input logic [1:0] alusrca,
    input logic [1:0] alusrcb,
    input logic [4:0] alucontrol,
    input logic pcsrc,

    input logic irwrite,
    input logic [2:0] regwrite,

    output logic [31:0] instr,
    output logic flag,
    output logic [31:0] addr,
    output logic [31:0] wd
);

  logic [31:0] pc;
  logic [31:0] pcnext;
  logic [31:0] data;
  logic [ 4:0] writereg;
  logic [31:0] wd3;
  logic [31:0] rd1;
  logic [31:0] rd2;
  logic [31:0] a;
  logic [31:0] b;
  logic [31:0] pcplus;
  logic [31:0] srca;
  logic [31:0] srcb;
  logic [31:0] alures;
  logic [31:0] aluout;

  flopenr #(
      .WIDTH(32)
  ) pcreg (
      clk,
      reset,
      pcen,
      pcnext,
      pc
  );

  mux2 #(
      .WIDTH(32)
  ) admux (
      pc,
      aluout,
      iord,
      addr
  );

  flopenr #(
      .WIDTH(32)
  ) instreg (
      clk,
      reset,
      irwrite,
      rd,
      instr
  );

  flopr #(
      .WIDTH(32)
  ) datareg (
      clk,
      reset,
      rd,
      data
  );

  mux2 #(
      .WIDTH(5)
  ) wrmux (
      instr[10:6],
      5'b11111,
      regdst,
      writereg
  );

  mux3 #(
      .WIDTH(32)
  ) wdmux (
      aluout,
      data,
      pc,
      memtoreg,
      wd3
  );

  regfile regfile (
      clk,
      regwrite,
      instr[15:11],
      instr[10:6],
      writereg,
      wd3,
      rd1,
      rd2
  );

  flopr #(
      .WIDTH(32)
  ) rd1reg (
      clk,
      reset,
      rd1,
      a
  );

  flopr #(
      .WIDTH(32)
  ) rd2reg (
      clk,
      reset,
      rd2,
      b
  );

  assign wd = b;

  mux3 #(
      .WIDTH(32)
  ) srcamux (
      pc,
      {27'b0, instr[15:11]},
      a,
      alusrca,
      srca
  );

  mux2 #(
      .WIDTH(32)
  ) pcplusmux (
      32'd2,
      32'd4,
      rd[5],
      pcplus
  );

  mux4 #(
      .WIDTH(32)
  ) srcbmux (
      b,
      pcplus,
      {{16{instr[31]}}, instr[31:16]},
      {{11{instr[31]}}, instr[31:11]},
      alusrcb,
      srcb
  );

  alu alu (
      srca,
      srcb,
      alucontrol,
      alures,
      flag
  );

  flopr #(
      .WIDTH(32)
  ) resreg (
      clk,
      reset,
      alures,
      aluout
  );

  mux2 #(
      .WIDTH(32)
  ) resmux (
      alures,
      aluout,
      pcsrc,
      pcnext
  );

endmodule
