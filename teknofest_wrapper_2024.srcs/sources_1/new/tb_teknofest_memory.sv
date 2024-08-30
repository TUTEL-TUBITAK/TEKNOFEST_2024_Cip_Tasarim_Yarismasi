`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2024 13:32:04
// Design Name: 
// Module Name: tb_teknofest_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_teknofest_memory();

logic clk_i, rst_ni, req, gnt, we, rvalid;
logic [31:0]  addr;
logic [127:0] wdata, rdata;
logic [15:0]  wstrb;

logic sys_rst, sys_clk, clk_ref;

wire [15:0] ddr2_dq;
wire [1:0]  ddr2_dqs_n;
wire [1:0]  ddr2_dqs_p;
wire [12:0] ddr2_addr;
wire [2:0]  ddr2_ba;
wire        ddr2_ras_n;
wire        ddr2_cas_n;
wire        ddr2_we_n;
wire        ddr2_reset_n;
wire        ddr2_ck_p;
wire        ddr2_ck_n;
wire        ddr2_cke;
wire        ddr2_cs_n;
wire        ddr2_odt;



teknofest_memory #(.USE_SRAM(0)) dut(.*);


initial begin
    clk_i <= 1'b0;
    forever begin
      #5ns;
      clk_i <= 1'b1;
      #5ns;
      clk_i <= 1'b0;
    end
  end

task cycle_start();
  #10ps;
endtask

task cycle_end();
  @(posedge ui_clk);
endtask

task wait_cycles(input int cycles);
   repeat(cycles) begin cycle_end(); end
endtask

task reset();
    rst_ni = 1'b0;
    req = 1'b0;
    we = 1'b0;
    addr = '0;
    wdata = '0;
    wstrb = '0;
    @(posedge ui_clk);
    rst_ni = 1'b1;
endtask


task write(
    input logic [31:0]  addr_i,
    input logic [127:0] wdata_i,
    input logic [15:0]  wstrb_i
);
    addr  = addr_i;
    wdata = wdata_i;
    wstrb = wstrb_i;
    req   = 1'b1;
    we    = 1'b1;
    cycle_start();
    while(!gnt) begin cycle_end(); cycle_start(); end
    cycle_end();
    req = 1'b0;
    we  = 1'b0;
endtask

task read(
    input  logic [31:0]  addr_i
);
    addr = addr_i;
    req  = 1'b1;
    we   = 1'b0;
    cycle_start();
    while(!gnt)  begin cycle_end(); cycle_start(); end
    cycle_end();
    req = 1'b0;
    we  = 1'b0;
    cycle_start();
    while(!rvalid)  begin cycle_end(); cycle_start(); end
    cycle_end();
endtask

initial begin
    reset();
    write(0, $random, '1);
    wait_cycles(5);
    read(0);
end

parameter CLKIN_PERIOD  = 3225;
parameter REFCLK_FREQ   = 200.0;
localparam real REFCLK_PERIOD = (1000000.0/(2*REFCLK_FREQ));
localparam RESET_PERIOD = 200000; //in pSec 

initial begin
    sys_rst = 1'b1;
    #RESET_PERIOD
    sys_rst = 1'b0;
end

initial
    sys_clk = 1'b0;
  always
    sys_clk = #(CLKIN_PERIOD/2.0) ~sys_clk;
    
initial
    clk_ref = 1'b0;
  always
    clk_ref = #REFCLK_PERIOD ~clk_ref;


endmodule
