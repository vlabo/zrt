const cpu = @import("mk20dx256.zig");
const Config = @import("config.zig");
const gpio = @import("gpio.zig");

var systick_ticks: u32 = 0;

pub fn init() void {
    cpu.SysTick.RVR = @enumToInt(Config.frequency) - 1;
    cpu.SysTick.CSR = cpu.SysTick_CSR_ENABLE_MASK | cpu.SysTick_CSR_TICKINT_MASK | cpu.SysTick_CSR_CLKSOURCE_MASK;
}

pub fn systick_get_ms() u32 {
    return systick_ticks * (1000 / 10) + (@enumToInt(Config.frequency) / 10 - (cpu.SysTick_CVR_CURRENT_MASK & cpu.SysTick.CVR)) / (@enumToInt(Config.frequency) / 1000);
}

