const std = @import("std");
const zrt = @import("zrt.zig");
const time = zrt.Time;
const Uart = zrt.Uart;
const gpio = zrt.gpio;
const interrupts = @import("teensy3_2/interrupt.zig");
const rt = @import("rtos/rt.zig");

const c = @cImport({
    @cInclude("usb.h");
});

pub fn main() void {
    var led = gpio.Output.new(13);
    led.set_high();
    // interrupts.disable();
    // interrupts.enable();
    c.usb_init();
}
