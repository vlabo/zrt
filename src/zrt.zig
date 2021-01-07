const build_options = @import("build_options");
const teensy3_2 = build_options.teensy3_2;
const raspberry = build_options.raspberry;

const Driver = @import("driver.zig");

const time = {
    if (teensy3_2) {
        return @import("teensy3_2/time.zig");
    } else if (raspberry) {
        return @import("raspberry/time.zig");
    } else {
        return {};
    }
};

const uart = {
    if (teensy3_2) {
        return @import("teensy3_2/uart.zig");
    } else if (raspberry) {
        return @import("raspberry/uart.zig");
    } else {
        return {};
    }
};

pub const gpio = {
    if (teensy3_2) {
        return @import("teensy3_2/gpio.zig");
    } else if (raspberry) {
        return @import("raspberry/gpio.zig");
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

pub const Time = Driver.TimeTemplate(time.sleep_ms);
pub const Uart = Driver.UartTemplate(uart.setup, uart.read_char, uart.write_char);

const main = @import("main.zig");

pub export fn zrt_start() noreturn {
    _ = start.setup();
    main.main();
}
