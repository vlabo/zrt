const cpu = @import("mk20dx256.zig");
const Config = @import("config.zig");
const gpio = @import("gpio.zig");

pub fn init() void {
    cpu.SysTick.RVR = @enumToInt(Config.frequency) - 1;
    cpu.SysTick.CSR = cpu.SysTick_CSR_ENABLE_MASK | cpu.SysTick_CSR_TICKINT_MASK | cpu.SysTick_CSR_CLKSOURCE_MASK;
}
