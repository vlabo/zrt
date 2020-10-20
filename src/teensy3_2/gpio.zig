const cpu = @import("mk20dx256.zig");

var PPDR align(32) = @intToPtr(*volatile u32, cpu.GPIOC_PDDR_ADDR);
var PORTC_PCR5 align(32) = @intToPtr(*volatile u32, cpu.PORTC_PCR5_ADDR);
var GPIOC_PSOR align(32) = @intToPtr(*volatile u32, cpu.GPIOC_PSOR_ADDR);
var GPIOC_PCOR align(32) = @intToPtr(*volatile u32, cpu.GPIOC_PCOR_ADDR);

pub fn setOutput(comptime pin: u8) void {
    PPDR.* = (1 << pin);

    // Set the MUX on Port C Pin 5 to use GPIO as the source
    PORTC_PCR5.* = cpu.port_pcr_mux(1) | cpu.PORT_PCR_SRE_MASK | cpu.PORT_PCR_DSE_MASK;
}

pub fn setHigh(comptime pin: u8) void {
    GPIOC_PSOR.* = (1 << pin);
}

pub fn setLow(comptime pin: u8) void {
    GPIOC_PCOR.* = (1 << 5);
}
