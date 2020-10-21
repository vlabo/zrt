const cpu = @import("mk20dx256.zig");

var WDOG_UNLOCK = @intToPtr(*volatile u16, cpu.WDOG_UNLOCK_ADDR);
var WDOG_STCTRLH = @intToPtr(*volatile u16, cpu.WDOG_STCTRLH_ADDR);

pub fn disable() void {
    // First, we have to unlock the watch dog by writing two magic
    // values. This has to happen within 20 bus clock cycles.
    WDOG_UNLOCK.* = cpu.WDOG_UNLOCK_SEQ1;
    WDOG_UNLOCK.* = cpu.WDOG_UNLOCK_SEQ2;
    // Now, we have to wait one bus clock cycle. Usually, the clock ratio is 1:1 or 1:2
    cpu.nop();
    cpu.nop();

    // And finally, we can disable the watchdog while allowing changes later on
    WDOG_STCTRLH.* = cpu.WDOG_STCTRLH_ALLOWUPDATE_MASK;
}
