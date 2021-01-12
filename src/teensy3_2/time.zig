const cpu = @import("mk20dx256.zig");
const config = @import("config.zig");

pub fn delay(duration: i32) void {
    var dur: i32 = duration;
    while (dur > 0) {
        var inner: i32 = @enumToInt(config.frequency) * 7 / 1000;
        while (inner > 0) {
            inner -= 1;
            cpu.nop();
        }
        dur -= 1;
    }
}

pub fn trigger_pendsv() void {
    cpu.SystemControl.ICSR = 0x10000000;
}
