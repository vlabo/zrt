const cpu = @import("nRF51.zig");
const io = @import("std").io;

pub fn setup() bool {
    cpu.GPIO.directionSet = 1 << 24;
    cpu.UartSetup.boundRate = 0x01D7E000; // 115200
    cpu.UartSetup.pinSelectTxd = 24;
    cpu.UartSetup.enable = 4;
    cpu.UartState.startTx = 1;
    return true;
}

pub fn write_char(ch: u8) bool {
    // Write character
    cpu.UartSetup.txd = ch;
    
    // Wait until space is available
    while (cpu.UartEvents.txReady != 0) {}
    return true;
}

pub fn read_char() u8 {
    return 0;
}
