// SPDX-License-Identifier: MIT
//
// Copyright (c) 2020 Vladimir Stoilov <vladimir.stoilov@protonmail.com>

const gpio = @import("gpio.zig");
const mmio = @import("mmio.zig");
const mbox = @import("mbox.zig");
const cpu = @import("cortex-a.zig");
const io = @import("std").io;

const Registers = struct {
    data_reg: u32,
    rsrecr: u32,
    reserved0: [14]u8,
    flag_reg: u32,
    reserved1: [8]u8,
    integer_bound_rate_divisor: u32,
    fractal_bound_rate_divisor: u32,
    line_control_reg: u32,
    control_reg: u32,
    interupt_fifo_level_reg: u32,
    interupt_mask_clear_reg: u32,
    raw_interupt_status_reg: u32,
    mask_interupt_status_reg: u32,
    interupt_clear_reg: u32,
    dma_control_reg: u32,
    test_control_reg: u32,
    integrateion_test_intput: u32,
    integration_test_output: u32,
    test_data_reg: u32,
};

pub const Uart = struct {
    registers: *volatile Registers = @intToPtr(*volatile Registers, mmio.UART_REGISTERS),

    const Self = @This();

    pub const Error = error{
        failed_to_write,
        failed_to_read,
    };

    pub const OutStream = io.OutStream(Self, Error, Self.write_string);
    pub const InStream = io.InStream(Self, Error, Self.read_string);

    pub fn new() Self {
        var self = Self{};
        self.init();
        return self;
    }

    pub fn init(self: Self) void {
        self.registers.control_reg = 0;

        // set up clock for consistent divisor values
        mbox.data[0] = 9 * 4;
        mbox.data[1] = mbox.MBOX_REQUEST;
        mbox.data[2] = mbox.Tag.set_clk_rate.to_int(); // set clock rate
        mbox.data[3] = 12;
        mbox.data[4] = 8;
        mbox.data[5] = 2; // UART clock
        mbox.data[6] = 4000000; // 4Mhz
        mbox.data[7] = 0; // clear turbo
        mbox.data[8] = mbox.Tag.last.to_int();
        var success = mbox.call(mbox.Channel.prop);

        var pins = [_]u8{ 14, 15 };
        gpio.set_pins_mode(&pins, gpio.Mode.alt0);

        self.registers.interupt_clear_reg = 0x7FF;
        self.registers.integer_bound_rate_divisor = 2;
        self.registers.fractal_bound_rate_divisor = 0xB;
        self.registers.interupt_mask_clear_reg = 0b11 << 5;
        self.registers.control_reg = 0x301;
    }

    pub fn send(self: Self, c: u8) void {
        while ((self.registers.flag_reg & 0x20) != 0) {
            cpu.nop();
        }
        self.registers.data_reg = c;
    }

    fn write_string(self: Self, string: []const u8) Error!usize {
        for (string) |value| {
            if (value == '\n')
                self.send('\r');
            self.send(value);
        }
        return string.len;
    }

    pub fn read_string(self: Self, buffer: []u8) Error!usize {
        for (buffer) |value, index| {
            buffer[index] = self.getc();
        }

        return buffer.len;
    }

    pub fn getc(self: Self) u8 {
        while ((self.registers.flag_reg & 0x10) != 0) {
            asm volatile ("nop");
        }

        var c: u8 = @intCast(u8, self.registers.data_reg);
        if (c == '\r') {
            return '\n';
        }

        return c;
    }

    pub fn get_out_stream(self: Self) OutStream {
        return OutStream{ .context = self };
    }

    pub fn get_in_stream(self: Self) InStream {
        return InStream{ .context = self };
    }
};

pub fn qsend(c: u8) void {
    mmio.write(0x3F201000, c);
}

pub fn qputs(string: []const u8) void {
    for (string) |value| {
        if (value == '\n')
            qsend('\r');
        qsend(value);
    }
}

pub fn uart_hex(d: u32) void {
    var n: u32 = 0;
    var c: i32 = 28;
    while (c >= 0) : (c -= 4) {
        // get highest tetrad
        n = (d >> @intCast(u5, c)) & 0xF;
        // 0-9 => '0'-'9', 10-15 => 'A'-'F'
        var v: u32 = if (n > 9) 0x37 else 0x30;
        n += v;
        qsend(@intCast(u8, n));
    }
}

test "uart registers" {
    const expectEqual = @import("std").testing.expectEqual;
    var addr = @intToPtr(*Registers, 0x10000000);
    expectEqual(@as(usize, 0x10000000), @ptrToInt(&addr.data_reg));
    expectEqual(@as(usize, 0x10000018), @ptrToInt(&addr.flag_reg));
    expectEqual(@as(usize, 0x10000024), @ptrToInt(&addr.integer_bound_rate_divisor));
    expectEqual(@as(usize, 0x10000028), @ptrToInt(&addr.fractal_bound_rate_divisor));
    expectEqual(@as(usize, 0x1000002C), @ptrToInt(&addr.line_control_reg));
    expectEqual(@as(usize, 0x10000030), @ptrToInt(&addr.control_reg));
    expectEqual(@as(usize, 0x10000038), @ptrToInt(&addr.interupt_mask_clear_reg));
    expectEqual(@as(usize, 0x10000044), @ptrToInt(&addr.interupt_clear_reg));
}
