const build_options = @import("build_options");
const teensy3_2 = build_options.teensy3_2;

const Driver = @import("driver.zig");

const time = {
    if (teensy3_2) {
        return @import("teensy3_2/time.zig");
    } else {
        return {};
    }
};

const uart = {
    if (teensy3_2) {
        return @import("teensy3_2/uart.zig");
    } else {
        return {};
    }
};

pub const gpio = {
    if (teensy3_2) {
        return @import("teensy3_2/gpio.zig");
    } else {
        return {};
    }
};

pub const systick = {
    if (teensy3_2) {
        return @import("teensy3_2/systick.zig");
    } else {
        return {};
    }
};

const start = {
    if (teensy3_2) {
        return @import("teensy3_2/startup.zig");
    } else {
        return {};
    }
};


pub const init = {
    if (teensy3_2) {
        return @import("teensy3_2/init.zig");
    } else {
        return {};
    }
};

pub const Time = Driver.TimeTemplate(time.sleep_ms);
pub const Uart = Driver.UartTemplate(uart.setup, uart.read_char, uart.write_char);

const entry = @import("main.zig");

export fn zrtMain() noreturn {
    init.setup();
    entry.main();
    while(true) {}
}
