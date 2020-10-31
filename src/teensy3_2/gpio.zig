const cpu = @import("mk20dx256.zig");

pub const Output = struct {
    pin: u5,

    const Self = @This();

    pub fn new(pin: u5) Self {
        const one: u32 = 1;
        cpu.GpioC.dataDirection = (one << pin);
        cpu.PortC.controlRegister[pin] = cpu.port_pcr_mux(1) | cpu.PORT_PCR_SRE_MASK | cpu.PORT_PCR_DSE_MASK;

        return Self{ .pin = pin };
    }

    fn set_high(self: Self) void {
        const one: u32 = 1;
        cpu.GpioC.setOutput = (one << self.pin);
    }

    fn set_low(self: Self) void {
        const one: u32 = 1;
        cpu.GpioC.clearOutput = (one << self.pin);
    }

    fn toggle(self: Self) void {
        const one: u32 = 1;
        cpu.GpioC.toggleOutput = (one << self.pin);
    }
};
