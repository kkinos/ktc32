module datapath (
    input logic clk,
    input logic reset,

    input logic [31:0] rd,
    input logic pcen,

    input logic iord,
    input logic irwrite,
    input logic memtoreg,
    input logic regwrite,
    input logic alusrca,
    input logic [1:0] alusrcb,
    input logic [2:0] alucontrol,
    input logic pcsrc,

    output logic [31:0] instr,
    output logic zero,
    output logic [31:0] addr,
    output logic [31:0] wd
);

  logic [31:0] pc;
  logic [31:0] pcnext;
  logic [31:0] data;
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
      rd[31:0],
      data
  );

  mux2 #(
      .WIDTH(32)
  ) wdmux (
      aluout,
      data,
      memtoreg,
      wd3
  );

  regfile regfile (
      clk,
      regwrite,
      instr[15:11],
      instr[10:6],
      instr[10:6],
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


  mux2 #(
      .WIDTH(32)
  ) srcamux (
      pc,
      a,
      alusrca,
      srca
  );

  mux2 #(
      .WIDTH(32)
  ) pcplusmux (
      32'd2,
      32'd4,
      rd[0],
      pcplus
  );


  mux4 #(
      .WIDTH(32)
  ) srcbmux (
      b,
      pcplus,
      32'b0,
      {{16{instr[31]}}, instr[31:16]},
      alusrcb,
      srcb
  );

  alu alu (
      srca,
      srcb,
      alucontrol,
      alures,
      zero
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
