const zrt = @import("zrt.zig");
const gpio = zrt.gpio;
const time = zrt.time;
const uart = zrt.uart;

export fn main() noreturn {
    uart.setup();
    gpio.setOutput(5);

    while (true) {
        gpio.setHigh(5);
        time.delay(100);

        gpio.setLow(5);
        time.delay(100);

        uart.putchar('a');
    }
}
