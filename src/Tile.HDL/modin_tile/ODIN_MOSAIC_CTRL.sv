module ODIN_MOSAIC_CTRL #(
    parameter N = 256,
    parameter M = 8
) (
    input  logic        clk,
    input  logic        rst,

    input  logic        mem_valid_axi,
    input  logic [31:0] mem_addr_axi,
    input  logic [31:0] mem_wdata_axi, 
    input  logic        mem_wstrb_axi, 
    output logic [31:0] mem_rdata_axi, 
    input  logic  [7:0] rvControl,     

    output logic    CTRL_READBACK_EVENT, 
    output logic    CTRL_PROG_EVENT, 
    output logic    [1:0] CTRL_OP_CODE,
    output logic    [2*M-1:0] CTRL_ADDR,
    output logic    [2*M-1:0] CTRL_PROG_DATA, 

    output logic    GATE_ACTIVITY,
    output logic    OPEN_LOOP,
    output logic    AER_SRC_CTRL_NNEUR,
    output logic    [M-1:0] MAX_NEUR,

    input logic     [31:0] SYNARRAY_RDATA, // hardcoded
    input logic     [31:0] NEUR_STATE // hardcoded
); 

localparam  ODIN_OP_NEUR = 2'b01,
            ODIN_OP_SYN = 2'b10,
            ODIN_OP_CTRL = 2'b00;

localparam  GATE_ACTIVITY_ENABLE = 16'd0, 
            OPEN_LOOP_ENABLE = 16'd1,
            A_S_C_NN_ENABLE = 16'd2,
            MAX_NEUR_ENABLE = 16'd3;

wire ns_wPre, ns_rPre, ns_OP;
wire [19:0] ODINAddr; // replaces csrAddr , BUT NOW needs to replace mem_addr
wire [31:0] ODIN_wdata;
logic [31:0] ODIN_data_out_mux; // mux to determine neuron or synapse data output to csrDOut

assign ns_rPre = mem_addr_axi[19];
assign ns_wPre = mem_addr_axi[18];
assign ns_OP = ns_rPre | ns_wPre;

Register #(
    .Width(20)
) addr_inst (
    .Clock(     clk),
    .Reset(     rst),
    .Set(       1'b0),
    .Enable(    mem_valid_axi),
    .In(        mem_addr_axi[19:0]),
    .Out(       ODINAddr)
);

Register #(
    .Width(32)
) data_in_inst (
    .Clock(     clk),
    .Reset(     rst),
    .Set(       1'b0),
    .Enable(    mem_valid_axi & mem_wstrb_axi),
    .In(        mem_wdata_axi),
    .Out(       ODIN_wdata)
);

Register #(
    .Width(2*M)
) ctrl_prog_data_inst (
    .Clock(     clk),
    .Reset(     rst),
    .Set(       1'b0),
    .Enable(    mem_valid_axi & mem_wstrb_axi  & ns_OP),
    .In(        mem_wdata_axi[2*M-1:0]),
    .Out(       CTRL_PROG_DATA) // is ODIN okay with this constantly changing!?!?! vs freeze when not using
); // might blowup if config registers used

assign CTRL_READBACK_EVENT = ODINAddr[19];
assign CTRL_PROG_EVENT = ODINAddr[18];
assign CTRL_OP_CODE = ODINAddr[17:16];
assign CTRL_ADDR = ODINAddr[15:0];
// prog data taken care of in reg 2

Register #(
    .Width(1)
)
 gate_activity_reg (
  .Clock(             clk),
  .Reset(             rst),
  .Set(               1'b0),
  .Enable(            (ODINAddr[17:16] == ODIN_OP_CTRL) && (ODINAddr[15:0]  == GATE_ACTIVITY_ENABLE)),
  .In(                ODIN_wdata[0]), 
  .Out(               GATE_ACTIVITY)
);


Register #(
    .Width(1)
)
 open_loop_reg (
  .Clock(             clk),
  .Reset(             rst),
  .Set(               1'b0),
  .Enable(            (ODINAddr[17:16] == ODIN_OP_CTRL) && (ODINAddr[15:0]  == OPEN_LOOP_ENABLE)),
  .In(                ODIN_wdata[0]), 
  .Out(               OPEN_LOOP)
);

Register #(
    .Width(1)
)
 A_S_C_NN_ENABLE_reg (
  .Clock(             clk),
  .Reset(             rst),
  .Set(               1'b0),
  .Enable(            (ODINAddr[17:16] == ODIN_OP_CTRL) && (ODINAddr[15:0]  == A_S_C_NN_ENABLE)),
  .In(                ODIN_wdata[0]), 
  .Out(               AER_SRC_CTRL_NNEUR)
);

Register #(
    .Width(8)
)
 max_neur_reg (
  .Clock(             clk),
  .Reset(             rst),
  .Set(               1'b0),
  .Enable(            (ODINAddr[17:16] == ODIN_OP_CTRL) && (ODINAddr[15:0]  == MAX_NEUR_ENABLE)),
  .In(                ODIN_wdata[7:0]), 
  .Out(               MAX_NEUR)
);

always @(*) begin
  case (ODINAddr[17:16])
    ODIN_OP_NEUR: ODIN_data_out_mux = NEUR_STATE;
    ODIN_OP_SYN:  ODIN_data_out_mux = SYNARRAY_RDATA;
    ODIN_OP_CTRL: begin
      case (ODINAddr[15:0])
        GATE_ACTIVITY_ENABLE: ODIN_data_out_mux = {31'b0, GATE_ACTIVITY};
        OPEN_LOOP_ENABLE:     ODIN_data_out_mux = {31'b0, OPEN_LOOP};
        A_S_C_NN_ENABLE:      ODIN_data_out_mux = {31'b0, AER_SRC_CTRL_NNEUR};
        MAX_NEUR_ENABLE:      ODIN_data_out_mux = {{(32-M){1'b0}}, MAX_NEUR};
        default:              ODIN_data_out_mux = 32'h0;
      endcase
    end
    default: ODIN_data_out_mux = 32'h0;
  endcase
end
 
/* // might be causing an unnecessary clock cycle delay
Register # (
  .Width(             32)
)
dout_inst (
  .Clock(             clk),
  .Reset(             rst),
  .Set(               1'b0),
  .Enable(            1'b1), // always reading, make sure to change if needed (only read when asked)
  .In(                ODIN_data_mux),  
  .Out(               mem_rdata_axi) 
);  */

assign mem_rdata_axi = ODIN_data_out_mux;


endmodule // EOF