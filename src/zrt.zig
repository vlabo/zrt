const build_options = @import("build_options");
const teensy3_2 = build_options.teensy3_2;
const microbit = build_options.microbit;

pub const gpio = {
    if (teensy3_2) {
        return @import("teensy3_2/gpio.zig");
    } else if(microbit) {
        return @import("microbit/gpio.zig");
    } else {
        return {};
    }
};

pub const time = {
    if (teensy3_2) {
        return @import("teensy3_2/time.zig");
    } else if(microbit) {
        return @import("microbit/time.zig");
    } else {
        return {};
    }
};

pub const uart = {
    if (teensy3_2) {
        return @import("teensy3_2/uart.zig");
    } else if(microbit) {
        return @import("microbit/uart.zig");
    } else {
        return {};
    }
};

// pub const systick = {
//     if (teensy3_2) {
//         return @import("teensy3_2/systick.zig");
//     } else {
//         return {};
//     }
// };

pub const init = {
    if (teensy3_2) {
        return @import("teensy3_2/init.zig");
    } else if(microbit) {
        return @import("microbit/init.zig");
    } else {
        return {};
    }
};

const entry = @import("main.zig");

export fn zrtMain() noreturn {
    init.setup();
    entry.main();
    while(true) {}
}
