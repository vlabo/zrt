const cpu = @import("mk20dx256.zig");

pub fn sleep_ms(duration: u64) void {
    var dur: u64 = duration;
    while (dur > 0) {
        var inner: u64 = 72000 / 10;
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
