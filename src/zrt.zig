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

pub const init = {
    if (teensy3_2) {
        return @import("teensy3_2/init.zig");
    } else if(raspberry) {
        return @import("raspberry/init.zig");
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
