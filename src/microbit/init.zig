extern var _sbss: u8;
extern var _ebss: u8;

pub fn setup() void {
    var bss = @ptrCast([*]u8, &_sbss);
    @memset(bss, 0, @ptrToInt(&_ebss) - @ptrToInt(&_sbss));
}

// void xPortPendSVHandler( void ) __attribute__ (( naked ));
// void xPortSysTickHandler( void );
// void vPortSVCHandler( void );

comptime {
    asm (
        \\ .global _start
        \\ _start:
        \\ stacktop: 
        \\ .long 0x20004000
        \\ .long resetHandler
        \\ .long NMIHandler
        \\ .long HardFaultHandler
        \\ .long 0
        \\ .long 0
        \\ .long 0
        \\ .long 0
        \\ .long 0
        \\ .long 0
        \\ .long 0
        \\ .long vPortSVCHandler
        \\ .long 0
        \\ .long 0
        \\ .long xPortPendSVHandler
        \\ .long xPortSysTickHandler
    );
}

extern fn zrtMain() noreturn;

export fn resetHandler() noreturn {
    zrtMain();
}
export fn NMIHandler() noreturn {
    while (true) {}
}

export fn HardFaultHandler() noreturn {
    while (true) {}
}

export fn SVCHandler() void {}

export fn PendSVHandler() void {}

export fn SysTickHandler() void {}
