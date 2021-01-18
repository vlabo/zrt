pub inline fn nop() void {
    asm volatile ("nop");
}

pub const GPIOStruct = struct {
    out: u32, //  Write GPIO port
    outSet: u32, // Set individual bits in GPIO port
    outClear: u32, // Clear individual bits in GPIO port
    in: u32, // Read GPIO port
    direction: u32, // Direction of GPIO pins
    directionSet: u32, // DIR set register
    directionClear: u32, // DIR clear register
    latch: u32, // Latch register indicating what GPIO pins that have met the criteria set in the PIN_CNF[n].SENSEregisters
    detectMode: u32, // Select between default DETECT signal behavior and LDETECT mode
};

pub var GPIO align(32) = @intToPtr(*volatile GPIOStruct, 0x50000000 + 0x504);
pub var GPIO_PIN1 align(32) = @intToPtr(*volatile [31]u32, 0x50000000 + 0x700); // Configuration of GPIO pins

const UartStateStruct = struct {
    startRx: u32,  // Start UART receiver
    stopRx: u32,  // Stop UART receiver
    startTx: u32,  // Start UART transmitter
    stopTx: u32,  // Stop UART transmitter
    @"suspend": u32  // Suspend UART
};

const UartEventsStruct = struct {
    cts: u32,  // CTS is activated (set low). Clear To Send.
    ncts: u32,  // CTS is deactivated (set high). Not Clear To Send.
    rxReady: u32,  // Data received in 
    txReady:u32,  // Data sent from 
    reserved: u32,
    txError: u32,   // Error detected
    rxTimeout: u32   // Receiver timeout
};


// SHORTS 0x200 // Shortcuts between local events and tasks

// INTENSET 0x304 // Enable interrupt
// INTENCLR 0x308 // Disable interrupt
// ERRORSRC 0x480 // Error source


const UartSetupStruct = struct {
    enable: u32, // Enable UART
    reserved1: u32,
    pinSelectRts: u32,  // Pin select for RTS
    pinSelectTxd: u32,  // Pin select for TXD
    pinSelectCts: u32,  // Pin select for CTS
    pinSelectRxd: u32,  // Pin select for RXD
    rxd: u32,  // RXD register
    txd: u32,  // TXD register
    reserved2: u32,
    boundRate: u32,  // Baud rate. Accuracy depends on the HFCLK source selected.
};

pub var UartState align(32) = @intToPtr(*volatile UartStateStruct, 0x40002000);
pub var UartEvents align(32) = @intToPtr(*volatile UartEventsStruct, 0x40002000 + 0x100);
pub var UartSetup align(32) = @intToPtr(*volatile UartSetupStruct, 0x40002000 + 0x500);
pub var UartConfig align(32) = @intToPtr(*volatile u32, 0x40002000 + 0x56C);      // Configuration of parity and hardware flow control


test "Gpio" {
    const expectEqual = @import("std").testing.expectEqual;
    var gpio align(32) = @intToPtr(*volatile GPIOStruct, 0x50000000 + 0x504);

    expectEqual(@as(usize, 0x50000000 + 0x508), @ptrToInt(&gpio.outSet));
    expectEqual(@as(usize, 0x50000000 + 0x50C), @ptrToInt(&gpio.outClear));
    expectEqual(@as(usize, 0x50000000 + 0x518), @ptrToInt(&gpio.directionSet));        
}

test "UartSetup" {
    const expectEqual = @import("std").testing.expectEqual;
    var setup align(32) = @intToPtr(*volatile UartSetupStruct, 0x40002000 + 0x500);
    expectEqual(@as(usize, 0x40002000 + 0x524), @ptrToInt(&setup.boundRate));
}