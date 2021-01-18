const cpu = @import("cortex-a.zig");

extern var __bss_start: u8;
extern var __bss_end: u8;

pub fn setup() void {
    // zero out bss section
    @memset(@as(*volatile [1]u8, &__bss_start), 0, @ptrToInt(&__bss_end) - @ptrToInt(&__bss_start));
}

extern fn zrtMain() noreturn;

export fn _start() linksection(".text.boot") callconv(.Naked) noreturn {
    if (cpu.get_cpu_id() & 0x3 != 0) {
        cpu.wfi();
    }
    asm volatile (
        \\ ldr     x1, =_start
        \\ mov     sp, x1
    );

    zrtMain();
}
