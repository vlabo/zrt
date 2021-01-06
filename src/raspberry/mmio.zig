// SPDX-License-Identifier: MIT
//
// Copyright (c) 2020 Vladimir Stoilov <vladimir.stoilov@protonmail.com>

const AtomicOrder = @import("builtin").AtomicOrder;

pub const BASE = 0x3F000000;
pub const GPIO = BASE + 0x00200000;
pub const VIDEO_CORE_MAILBOX = BASE + 0x0000B880;
pub const UART_REGISTERS = BASE + 0x00201000;

pub fn write(reg: usize, data: u32) void {
    @fence(AtomicOrder.SeqCst);
    @intToPtr(*volatile u32, reg).* = data;
}

pub fn read(reg: usize) u32 {
    @fence(AtomicOrder.SeqCst);
    return @intToPtr(*volatile u32, reg).*;
}
