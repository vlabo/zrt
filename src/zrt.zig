const build_options = @import("build_options");
const teensy3_2 = build_options.teensy3_2;

pub const gpio = {
    if(teensy3_2) {
        return @import("teensy3_2/gpio.zig");
    } else {
        return {};
    }
};

pub const time = {
    if(teensy3_2) {
        return @import("teensy3_2/time.zig");
    } else {
        return {};
    }
};

pub const uart = {
    if(teensy3_2) {
        return @import("teensy3_2/uart.zig");
    } else {
        return {};
    }
};

