// SPDX-License-Identifier: MIT
//
// Copyright (c) 2020 Vladimir Stoilov <vladimir.stoilov@protonmail.com>

const mmio = @import("mmio.zig");
const timer = @import("time.zig");

const Property = struct {
    first: u32,
    second: u32,
    reserved: u32,

    fn enable_pin(self: *volatile Property, pin: u8) void {
        var one: u32 = 1;
        if (pin < 32) {
            self.first |= (one << @intCast(u5, pin));
        } else {
            self.second |= (one << @intCast(u5, pin - 32));
        }
    }

    fn disable_pin(self: *volatile Property, pin: u8) void {
        var one: u32 = 1;
        if (pin < 32) {
            self.first |= ~(one << @intCast(u5, pin));
        } else {
            self.second |= ~(one << @intCast(u5, pin - 32));
        }
    }

    fn clear(self: *volatile Property) void {
        self.first = 0;
        self.second = 0;
    }
};

/// Reference: https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
const GPIO = struct {
    functions: [6]u32,
    reserved1: u32,
    output_set: Property,
    output_clear: Property,
    pin_level: Property,
    event_detect_system: Property,
    rising_edgne_detect: Property,
    falling_edge_detect: Property,
    high_detect: Property,
    low_detect: Property,
    async_rising_edge: Property,
    async_falling_edge: Property,
    pull_up_down: u32,
    pull_up_down_clock: Property,

    fn get_pin_offset(pin: u8) u5 {
        return @intCast(u5, (pin % 10) * 3);
    }

    fn zero_out_pin_bits(state: *volatile u32, pin: u8) void {
        var pin_offset: u5 = GPIO.get_pin_offset(pin);
        var ones: u32 = 0b111;
        var mask: u32 = ones << pin_offset;
        state.* &= ~mask;
    }

    fn set_pin_mode(self: *volatile GPIO, pin: u8, mode: Mode) void {
        var select = &self.functions[pin / 10];
        GPIO.zero_out_pin_bits(select, pin);
        select.* |= (mode.to_number() << GPIO.get_pin_offset(pin));
    }
};

pub const Mode = enum {
    input = 0b000, // GPIO Pin is an input
    output = 0b001, // GPIO Pin is an output
    alt0 = 0b100, // GPIO Pin takes alternate function 0
    alt1 = 0b101, // GPIO Pin takes alternate function 1
    alt2 = 0b110, // GPIO Pin takes alternate function 2
    alt3 = 0b111, // GPIO Pin takes alternate function 3
    alt4 = 0b011, // GPIO Pin takes alternate function 4
    alt5 = 0b010, // GPIO Pin takes alternate function 5

    fn to_number(self: Mode) u32 {
        return @enumToInt(self);
    }
};

var gpio align(32) = @intToPtr(*volatile GPIO, mmio.GPIO);

pub fn set_pins_mode(pins: []u8, mode: Mode) void {
    if (pins.len <= 0) {
        return;
    }

    for (pins) |pin| {
        gpio.set_pin_mode(pin, mode);
    }

    gpio.pull_up_down = 0;
    timer.wait_for_cicles(150);

    for (pins) |pin| {
        gpio.pull_up_down_clock.enable_pin(pin);
    }
    timer.wait_for_cicles(150);
    gpio.pull_up_down_clock.clear();
}

pub fn set_pin_mode(pin: u8, mode: Mode) void {
    var pins = [_]u8{pin};
    set_pins_mode(&pins, mode);
}

pub fn output_set(pin: u8, on: bool) void {
    if (on) {
        gpio.output_set.enable_pin(pin);
    } else {
        gpio.output_set.disable_pin(pin);
    }
}

test "gpio registers" {
    const expectEqual = @import("std").testing.expectEqual;
    var registers = @intToPtr(*GPIO, 0x10000000);
    expectEqual(@as(usize, 0x10000000), @ptrToInt(&registers.functions));

    expectEqual(@as(usize, 0x1000001C), @ptrToInt(&registers.output_set.first));
    expectEqual(@as(usize, 0x10000020), @ptrToInt(&registers.output_set.second));

    expectEqual(@as(usize, 0x10000028), @ptrToInt(&registers.output_clear.first));
    expectEqual(@as(usize, 0x1000002C), @ptrToInt(&registers.output_clear.second));

    expectEqual(@as(usize, 0x10000034), @ptrToInt(&registers.pin_level.first));
    expectEqual(@as(usize, 0x10000038), @ptrToInt(&registers.pin_level.second));

    expectEqual(@as(usize, 0x10000040), @ptrToInt(&registers.event_detect_system.first));
    expectEqual(@as(usize, 0x10000044), @ptrToInt(&registers.event_detect_system.second));

    expectEqual(@as(usize, 0x1000004C), @ptrToInt(&registers.rising_edgne_detect.first));
    expectEqual(@as(usize, 0x10000050), @ptrToInt(&registers.rising_edgne_detect.second));

    expectEqual(@as(usize, 0x10000058), @ptrToInt(&registers.falling_edge_detect.first));
    expectEqual(@as(usize, 0x1000005C), @ptrToInt(&registers.falling_edge_detect.second));

    expectEqual(@as(usize, 0x10000064), @ptrToInt(&registers.high_detect.first));
    expectEqual(@as(usize, 0x10000068), @ptrToInt(&registers.high_detect.second));

    expectEqual(@as(usize, 0x10000070), @ptrToInt(&registers.low_detect.first));
    expectEqual(@as(usize, 0x10000074), @ptrToInt(&registers.low_detect.second));

    expectEqual(@as(usize, 0x1000007C), @ptrToInt(&registers.async_rising_edge.first));
    expectEqual(@as(usize, 0x10000080), @ptrToInt(&registers.async_rising_edge.second));

    expectEqual(@as(usize, 0x10000088), @ptrToInt(&registers.async_falling_edge.first));
    expectEqual(@as(usize, 0x1000008C), @ptrToInt(&registers.async_falling_edge.second));

    expectEqual(@as(usize, 0x10000094), @ptrToInt(&registers.pull_up_down));

    expectEqual(@as(usize, 0x10000098), @ptrToInt(&registers.pull_up_down_clock.first));
    expectEqual(@as(usize, 0x1000009C), @ptrToInt(&registers.pull_up_down_clock.second));
}
