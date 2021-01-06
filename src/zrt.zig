const build_options = @import("build_options");
const teensy3_2 = build_options.teensy3_2;
const raspberry = build_options.raspberry;

const UT = @import("uart.zig");

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

pub const Uart = UT.UartTemplate(uart.setup, uart.read_char, uart.write_char);

pub const systick = {
    if (teensy3_2) {
        return @import("teensy3_2/systick.zig");
    } else if (raspberry) {
        return @import("raspberry/systick.zig");
    } else {
        return {};
    }
};

const start = {
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

pub export fn zrt_start() noreturn {
    _ = start.setup();
    main.main();
}
