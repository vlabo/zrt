const cpu = @import("mk20dx256.zig");
const Config = @import("config.zig");
const Uart = @import("uart.zig").Uart;
const interupts = @import("interrupt.zig");
const gpio = @import("gpio.zig");

var systick_ticks: u32 = 0;
var out: Uart.OutStream = undefined;

pub fn init() void {
    var uart = Uart.new();
    out = uart.get_out_stream();
    // cpu.SysTick.RVR = @enumToInt(Config.frequancy) / 10;
    // cpu.SysTick.CSR = cpu.SysTick_CSR_ENABLE_MASK | cpu.SysTick_CSR_TICKINT_MASK | cpu.SysTick_CSR_CLKSOURCE_MASK;
    // cpu.SystemControl.ICSR = 0x10000000;
    createTask();
    out.print("createTask\n", .{}) catch {};
}

pub fn systick_get_ms() u32 {
    return systick_ticks * (1000 / 10) + (@enumToInt(Config.frequancy) / 10 - (cpu.SysTick_CVR_CURRENT_MASK & cpu.SysTick.CVR)) / (@enumToInt(Config.frequancy) / 1000);
}

pub extern fn svc_handler() void;
// {
//     out.print("{x}\n", .{stackPointer}) catch {};
//     var curr_stack = @intToPtr([*]u8, stackPointer);
//     out.print("{x}\n", .{stack}) catch {};
// }
// {
    //cpu.SystemControl.ICSR = 0x10000000;
    // var value = asm volatile ("mov %[value], lr"
    //     : [value] "=r" (-> usize)
    // );
    // out.print("0x{x} \n", .{value}) catch {};
//}

pub export fn isr() void {
    var value = asm volatile ("mov %[value], lr"
        : [value] "=r" (-> usize)
    );
    out.print("sv_isr: 0x{x} \n", .{value}) catch {};
}

comptime {
    asm (
        \\.global svc_handler;
        \\svc_handler:
        \\ cpsid i
        \\ ldr r0, =stackPointer
        \\ ldr r0, [r0]
        \\ ldmia r0!, {r4-r11, lr}
        \\ orr lr, lr, #0b100
        \\ msr psp, r0
        \\ cpsie i
        \\ bx lr
    );
}

pub export fn sv_isr() void {}

pub export fn test_task() noreturn {
    var led = gpio.Output.new(13);
    led.set_high();
    while (true) {
        out.print("Yuoo\n", .{}) catch {};
    }
}

const HardwareStackFrame = struct {
    R0: usize,
    R1: usize,
    R2: usize,
    R3: usize,
    R12: usize,
    LR: usize,
    PC: usize,
    xPSR: usize,
};

const SoftwareStackFrame = struct {
    R4: usize,
    R5: usize,
    R6: usize,
    R7: usize,
    R8: usize,
    R9: usize,
    R10: usize,
    R11: usize,
    LR: usize,
};

const stackSize: u32 = 1024;
var stack: [stackSize]u8 = [1]u8{0} ** stackSize;

export var stackPointer: usize = 0;

fn createTask() void {
    var hwStack = HardwareStackFrame{
        .R0 = 0,
        .R1 = 1,
        .R2 = 2,
        .R3 = 3,
        .R12 = 12,
        .LR = @ptrToInt(test_task),
        .PC = @ptrToInt(test_task),
        .xPSR = 0x01000000,
    };
    var swStack = SoftwareStackFrame{
        .R4 = 4,
        .R5 = 5,
        .R6 = 6,
        .R7 = 7,
        .R8 = 8,
        .R9 = 9,
        .R10 = 10,
        .R11 = 11,
        .LR = 0xFFFFFFF9,
    };
    var stackLen = stack.len;

    stackLen -= @sizeOf(HardwareStackFrame);
    @memcpy(@ptrCast([*]u8, &stack[stackLen]), @ptrCast([*]const u8, &hwStack), @sizeOf(HardwareStackFrame));

    stackLen -= @sizeOf(SoftwareStackFrame);
    @memcpy(@ptrCast([*]u8, &stack[stackLen]), @ptrCast([*]const u8, &swStack), @sizeOf(SoftwareStackFrame));

    stackPointer = @ptrToInt(&stack[stackLen]);
    out.print("{d}\n", .{stack[stackLen]}) catch {};

    // out.print("{x}\n", .{stackPointer}) catch {};
    // var curr_stack = @intToPtr([*]u8, stackPointer);
    // out.print("{x}\n", .{stack}) catch {};
}
