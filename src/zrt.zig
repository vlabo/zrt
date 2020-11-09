const build_options = @import("build_options");
const teensy3_2 = build_options.teensy3_2;

pub const gpio = {
    if (teensy3_2) {
        return @import("teensy3_2/gpio.zig");
    } else {
        return {};
    }
};

pub const time = {
    if (teensy3_2) {
        return @import("teensy3_2/time.zig");
    } else {
        return {};
    }
};

pub const uart = {
    if (teensy3_2) {
        return @import("teensy3_2/uart.zig");
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

pub const start = {
    if (teensy3_2) {
        return @import("teensy3_2/startup.zig");
    } else {
        return {};
    }
};

const main = @import("main.zig");

export fn _start() linksection(".startup") noreturn {
    start.setup();
    main.main();
}
