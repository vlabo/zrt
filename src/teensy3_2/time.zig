const cpu = @import("mk20dx256.zig");

pub fn delay(duration: i32) void {
    var dur: i32 = duration;
    while (dur > 0) {
        var inner: i32 = 72000 / 10;
        while (inner > 0) {
            inner -= 1;
            cpu.nop();
            cpu.nop();
            cpu.nop();
            cpu.nop();
            cpu.nop();
            cpu.nop();
            cpu.nop();
        }
        dur -= 1;
    }
}
