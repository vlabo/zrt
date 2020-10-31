const cpu = @import("mk20dx256.zig");

pub fn disable() void {
    // First, we have to unlock the watch dog by writing two magic
    // values. This has to happen within 20 bus clock cycles.
    cpu.Watchdog.unlock = cpu.WDOG_UNLOCK_SEQ1;
    cpu.Watchdog.unlock = cpu.WDOG_UNLOCK_SEQ2;
    // Now, we have to wait one bus clock cycle. Usually, the clock ratio is 1:1 or 1:2
    cpu.nop();
    cpu.nop();

    // And finally, we can disable the watchdog while allowing changes later on
    cpu.Watchdog.statusAndControlHigh = cpu.WDOG_STCTRLH_ALLOWUPDATE_MASK;
}
