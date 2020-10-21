const watchdog = @import("watchdog.zig");
const c = @cImport(@cInclude("startup.h"));
const cpu = @import("mk20dx256.zig");

var PMC_REGSC = @intToPtr(*volatile u8, cpu.PMC_REGSC_ADDR);
var SIM_SCGC5 = @intToPtr(*volatile u32, cpu.SIM_SCGC5_ADDR);

pub fn setup() void {
    // The CPU has a watchdog feature which is on by default,
    // so we have to configure it to not have nasty reset-surprises
    // later on.
    watchdog.disable();

    // If the system was in VLLS mode, some peripherials and
    // the I/O pins are in latched mode. We need to restore
    // config and can then acknowledge the isolation to get back
    // to normal. For now, we'll just ack TODO: properly do this
    // if (PMC_REGSC & PMC_REGSC_ACKISO_MASK) PMC_REGSC |= PMC_REGSC_ACKISO_MASK;

    // There is a write-once-after-reset register that allows to
    // set which power states are available. Let's set it here.

    if (PMC_REGSC.* & cpu.PMC_REGSC_ACKISO_MASK != 0) {
        PMC_REGSC.* |= cpu.PMC_REGSC_ACKISO_MASK;
    }

    // For the sake of simplicity, enable all GPIO port clocks
    SIM_SCGC5.* |= (cpu.SIM_SCGC5_PORTA_MASK | cpu.SIM_SCGC5_PORTB_MASK | cpu.SIM_SCGC5_PORTC_MASK | cpu.SIM_SCGC5_PORTD_MASK | cpu.SIM_SCGC5_PORTE_MASK);

    c.c_startup();
}
