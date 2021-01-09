const zrt = @import("zrt.zig");
const gpio = zrt.gpio;
const time = zrt.time;
const Uart = zrt.uart.Uart;
// const Systick = zrt.systick;

extern var _sbss: u8;
extern var _ebss: u8;
pub fn main() noreturn {
    asm volatile ("SVC 0");
    var uart = Uart.new();
    var out = uart.get_out_stream();
    var in = uart.get_in_stream();
    var led = gpio.Output.new(13);
    // var led1 = gpio.Output.new(23);
    // var input = gpio.Input.new(14);

    out.print("bss: {} - {} = {}\n", .{ @ptrToInt(&_ebss), @ptrToInt(&_sbss), @ptrToInt(&_ebss) - @ptrToInt(&_sbss) }) catch {};

    // var value = asm volatile ("mov %[value], lr"
    // : [value] "=r" (-> usize)
    // );
    // out.print("main: 0x{x} \n", .{value}) catch {};

    while (true) {
        led.toggle();
        time.delay(1000);
        // time.trigger_pendsv();
        out.print("ss \n", .{}) catch {};
    }
}
