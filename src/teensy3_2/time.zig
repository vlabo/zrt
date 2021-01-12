const cpu = @import("mk20dx256.zig");
const config = @import("config.zig");

pub fn sleep_ms(duration: u64) void {
    var dur: u64 = duration;
    while (dur > 0) {
        var inner: u64 = @enumToInt(config.frequency) / 1000;
        while (inner > 0) {
            inner -= 1;
            cpu.nop();
        }
        dur -= 1;
    }
}
