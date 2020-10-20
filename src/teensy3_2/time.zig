pub fn delay(duration: i32) void {
    var dur: i32 = duration;
    while (dur > 0) {
        var inner: i32 = 72000 / 10;
        while (inner > 0) {
            inner -= 1;
            asm volatile ("nop");
            asm volatile ("nop");
            asm volatile ("nop");
            asm volatile ("nop");
            asm volatile ("nop");
            asm volatile ("nop");
            asm volatile ("nop");
        }
        dur -= 1;
    }
}