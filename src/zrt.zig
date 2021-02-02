const Target = @import("target.zig");
const Driver = @import("driver.zig");

pub const gpio = switch (Target.current) {
    .teensy => {
        return @import("teensy3_2/gpio.zig");
    },
};

pub const Time = switch (Target.current) {
    .teensy => {
        const time = @import("teensy3_2/time.zig");
        Driver.TimeTemplate(time.sleep_ms);
    },
};

pub const Uart = switch (Target.current) {
    .teensy => {
        const uart = @import("teensy3_2/uart.zig");
        return Driver.UartTemplate(uart.setup, uart.read_char, uart.write_char);
    },
};

const entry = @import("main.zig");

export fn zrtMain() noreturn {
    if (Target.current == Target.Targets.teensy) {
        const init = @import("teensy3_2/init.zig");
        init.setup();
    }

    entry.main();
    while (true) {}
}
