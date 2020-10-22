const cpu = @import("mk20dx256.zig");

var GPIOC_PPDR align(32) = @intToPtr(*volatile u32, cpu.GPIOC_PDDR_ADDR);
var GPIOC_PSOR align(32) = @intToPtr(*volatile u32, cpu.GPIOC_PSOR_ADDR);
var GPIOC_PCOR align(32) = @intToPtr(*volatile u32, cpu.GPIOC_PCOR_ADDR);

var PORTC_PCR = @intToPtr(*volatile [32]u32, cpu.PORTC_PCR_ADDR);

pub const Output = struct {
    pin: u5,

    const Self = @This();

    pub fn new(pin: u5) Self {
        const one: u32 = 1;
        GPIOC_PPDR.* = (one << pin);
        PORTC_PCR[pin] = cpu.port_pcr_mux(1) | cpu.PORT_PCR_SRE_MASK | cpu.PORT_PCR_DSE_MASK;

        return Self{ .pin = pin };
    }

    fn set_high(self: Self) void {
        const one: u32 = 1;
        GPIOC_PSOR.* = (one << self.pin);
    }

    fn set_low(self: Self) void {
        const one: u32 = 1;
        GPIOC_PCOR.* = (one << self.pin);
    }
};