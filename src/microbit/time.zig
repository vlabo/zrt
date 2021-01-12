const cpu = @import("nRF51.zig");

pub fn delay(duration: i32) void {
    var dur: i32 = duration;
    while (dur > 0) {
        var inner: i32 = 16000 * 7;
        while (inner > 0) {
            inner -= 1;
            cpu.nop();
        }
        dur -= 1;
    }
}