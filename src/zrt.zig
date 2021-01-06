const build_options = @import("build_options");
const teensy3_2 = build_options.teensy3_2;
const raspberry = build_options.raspberry;

pub const gpio = {
    if (teensy3_2) {
        return @import("teensy3_2/gpio.zig");
    } else if (raspberry) {
        return @import("raspberry/gpio.zig");
    } else {
        return {};
    }
};

pub const time = {
    if (teensy3_2) {
        return @import("teensy3_2/time.zig");
    } else if (raspberry) {
        return @import("raspberry/time.zig");
    } else {
        return {};
    }
};

pub const uart = {
    if (teensy3_2) {
        return @import("teensy3_2/uart.zig");
    } else if (raspberry) {
        return @import("raspberry/uart.zig");
    } else {
        return {};
    }
};

pub const systick = {
    if (teensy3_2) {
        return @import("teensy3_2/systick.zig");
    } else if (raspberry) {
        return @import("raspberry/systick.zig");
    } else {
        return {};
    }
};

pub const start = {
    if (teensy3_2) {
        return @import("teensy3_2/startup.zig");
    } else if (raspberry) {
        return @import("raspberry/startup.zig");
    } else {
        return {};
    }
};

pub const cpu = {
    if (teensy3_2) {
        return @import("teensy3_2/mk20dx256.zig");
    } else if (raspberry) {
        return @import("raspberry/cortex-a.zig");
    } else {
        return {};
    }
};

const main = @import("main.zig");

export fn _start() linksection(".text.boot") callconv(.Naked) noreturn {
    if (raspberry) {
        if (cpu.get_cpu_id() & 0x3 != 0) {
            cpu.wfi();
        }
        asm volatile (
            \\ ldr     x1, =_start
            \\ mov     sp, x1
        );
    }

    start.setup();
    main.main();
}
