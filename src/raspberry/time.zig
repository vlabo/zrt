const cpu = @import("cortex-a.zig");
const mmio = @import("mmio.zig");

pub fn wait_for_cicles(cicles: usize) void {
    var i: usize = cicles;
    while (i > 0) {
        i -= 1;
        cpu.nop();
    }
}

pub fn sleep_ms(ms: u64) void {
    const freq = cpu.get_counter_timer_freq();
    const start_time = cpu.get_counter_timer();

    var end_time = start_time + ((freq / 1000) * ms);

    while (true) {
        var current_time = cpu.get_counter_timer();
        if (current_time >= end_time) {
            break;
        }
    }
}
