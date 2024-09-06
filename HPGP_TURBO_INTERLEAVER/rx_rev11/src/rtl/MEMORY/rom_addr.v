`timescale 1ps/1ps

module rom_addr #(
    parameter D_WIDTH,
    parameter A_WIDTH
    )(
	clk,
    n_rst,
	raddr,
    mod_int_dint,
	data_out
);



input	                   clk, n_rst;

input	    [A_WIDTH-1:0]  raddr;
input                      mod_int_dint;

output	reg [A_WIDTH-1:0]  data_out;


// paraller deinterleaver rom
reg [A_WIDTH-1:0] rom_d_16 [0 : 2**A_WIDTH-1];

initial  begin
    $readmemh("../src/rtl/RX_ROM/deint_rom_20bit.txt", rom_d_16_0);
end

// paraller interleaver rom
reg [A_WIDTH-1:0] rom_i_16 [0 : 2**A_WIDTH-1];

initial  begin
    $readmemh("../src/rtl/RX_ROM/int_rom_20bit.txt", rom_i_16_0);
end

always @(*) begin
    if (mod_int_dint == 1'b1) begin
        data_out = rom_i_16[raddr];
    end 
    else begin
        data_out = rom_d_16[raddr];
    end
end


endmodule