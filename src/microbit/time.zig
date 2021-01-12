const cpu = @import("nRF51.zig");

pub fn sleep_ms(duration: u64) void {
    var dur: u64 = duration;
    while (dur > 0) {
        var inner: u64 = 16000 * 4;
        while (inner > 0) {
            inner -= 1;
            cpu.nop();
        }
        dur -= 1;
    }
}