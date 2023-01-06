module alu (
    input logic [31:0] srca,
    input logic [31:0] srcb,
    input logic [ 4:0] alucontrol,

    output logic [31:0] res,
    output logic flag
);

  always_comb begin
    case (alucontrol)
      5'b00000: begin
        res  = srca;
        flag = 0;
      end
      5'b00001: begin
        res  = srcb + srca;
        flag = 0;
      end
      5'b00010: begin
        res  = srcb - srca;
        flag = 0;
      end
      5'b00011: begin
        res  = srcb & srca;
        flag = 0;
      end
      5'b00100: begin
        res  = srcb | srca;
        flag = 0;
      end
      5'b00101: begin
        res  = srcb ^ srca;
        flag = 0;
      end
      5'b00110: begin
        res  = srcb << srca;
        flag = 0;
      end
      5'b00111: begin
        res  = srcb >> srca;
        flag = 0;
      end
      5'b01000: begin
        res  = $signed(srcb) >>> srca;
        flag = 0;
      end
      5'b01001: begin
        res  = (srcb == srca) ? 1 : 0;
        flag = (srcb == srca) ? 1 : 0;
      end
      5'b01010: begin
        res  = (srcb != srca) ? 1 : 0;
        flag = (srcb != srca) ? 1 : 0;
      end
      5'b01011: begin
        res  = (srcb < srca) ? 1 : 0;
        flag = (srcb < srca) ? 1 : 0;
      end
      5'b01100: begin
        res  = (srcb > srca) ? 1 : 0;
        flag = (srcb > srca) ? 1 : 0;
      end
      5'b01101: begin
        res  = (srcb >= srca) ? 1 : 0;
        flag = (srcb >= srca) ? 1 : 0;
      end
      5'b01110: begin
        res  = ($signed(srcb) < $signed(srca)) ? 1 : 0;
        flag = ($signed(srcb) < $signed(srca)) ? 1 : 0;
      end
      5'b01111: begin
        res  = ($signed(srcb) > $signed(srca)) ? 1 : 0;
        flag = ($signed(srcb) > $signed(srca)) ? 1 : 0;
      end
      5'b10000: begin
        res  = ($signed(srcb) >= $signed(srca)) ? 1 : 0;
        flag = ($signed(srcb) >= $signed(srca)) ? 1 : 0;
      end
      5'b10001: begin
        res  = srcb << 16;
        flag = 'x;
      end
      default: begin
        res  = 'x;
        flag = 'x;
      end

    endcase
  end


endmodule
