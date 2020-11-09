const cpu = @import("mk20dx256.zig");

const Bank = enum {
    A, B, C, D, E
};

const IO = struct {
    bank: Bank,
    shift: u5,
};

const IoMap = [_]IO{
    IO{ .bank = Bank.B, .shift = 16 }, // GPIO 0
    IO{ .bank = Bank.B, .shift = 17 }, // GPIO 1
    IO{ .bank = Bank.D, .shift = 0 }, // GPIO 2
    IO{ .bank = Bank.A, .shift = 12 }, // GPIO 3
    IO{ .bank = Bank.A, .shift = 13 }, // GPIO 4
    IO{ .bank = Bank.D, .shift = 7 }, // GPIO 5
    IO{ .bank = Bank.D, .shift = 4 }, // GPIO 6
    IO{ .bank = Bank.D, .shift = 2 }, // GPIO 7
    IO{ .bank = Bank.D, .shift = 3 }, // GPIO 8
    IO{ .bank = Bank.C, .shift = 3 }, // GPIO 9
    IO{ .bank = Bank.C, .shift = 4 }, // GPIO 10
    IO{ .bank = Bank.C, .shift = 6 }, // GPIO 11
    IO{ .bank = Bank.C, .shift = 7 }, // GPIO 12
    IO{ .bank = Bank.C, .shift = 5 }, // GPIO 13
    IO{ .bank = Bank.D, .shift = 1 }, // GPIO 14
    IO{ .bank = Bank.C, .shift = 0 }, // GPIO 15
    IO{ .bank = Bank.B, .shift = 0 }, // GPIO 16
    IO{ .bank = Bank.B, .shift = 1 }, // GPIO 17
    IO{ .bank = Bank.B, .shift = 3 }, // GPIO 18
    IO{ .bank = Bank.B, .shift = 2 }, // GPIO 19
    IO{ .bank = Bank.D, .shift = 5 }, // GPIO 20
    IO{ .bank = Bank.D, .shift = 6 }, // GPIO 21
    IO{ .bank = Bank.C, .shift = 1 }, // GPIO 22
    IO{ .bank = Bank.C, .shift = 2 }, // GPIO 23
    IO{ .bank = Bank.A, .shift = 5 }, // GPIO 24
    IO{ .bank = Bank.B, .shift = 19 }, // GPIO 25
    IO{ .bank = Bank.E, .shift = 1 }, // GPIO 26
    IO{ .bank = Bank.C, .shift = 9 }, // GPIO 27
    IO{ .bank = Bank.C, .shift = 8 }, // GPIO 28
    IO{ .bank = Bank.C, .shift = 10 }, // GPIO 29
    IO{ .bank = Bank.C, .shift = 11 }, // GPIO 30
    IO{ .bank = Bank.E, .shift = 0 }, // GPIO 31
    IO{ .bank = Bank.B, .shift = 18 }, // GPIO 32
    IO{ .bank = Bank.B, .shift = 4 }, // GPIO 33
};

fn get_gpio(bank: Bank) *volatile cpu.Gpio {
    switch (bank) {
        Bank.A => return cpu.GpioA,
        Bank.B => return cpu.GpioB,
        Bank.C => return cpu.GpioC,
        Bank.D => return cpu.GpioD,
        Bank.E => return cpu.GpioE,
    }
}

fn get_port(bank: Bank) *volatile cpu.Port {
    switch (bank) {
        Bank.A => return cpu.PortA,
        Bank.B => return cpu.PortB,
        Bank.C => return cpu.PortC,
        Bank.D => return cpu.PortD,
        Bank.E => return cpu.PortE,
    }
}

pub const Output = struct {
    output: IO,

    const Self = @This();

    pub fn new(pin: u5) Self {
        var output = IoMap[pin];
        const one: u32 = 1;
        get_gpio(output.bank).dataDirection |= (one << output.shift);
        get_port(output.bank).controlRegister[output.shift] = cpu.port_pcr_mux(1) | cpu.PORT_PCR_SRE_MASK | cpu.PORT_PCR_DSE_MASK;

        return Self{ .output = output };
    }

    fn set_high(self: Self) void {
        const one: u32 = 1;
        get_gpio(self.output.bank).setOutput = (one << self.output.shift);
    }

    fn set_low(self: Self) void {
        const one: u32 = 1;
        get_gpio(self.output.bank).clearOutput = (one << self.output.shift);
    }

    fn toggle(self: Self) void {
        const one: u32 = 1;
        get_gpio(self.output.bank).toggleOutput = (one << self.output.shift);
    }
};

pub const Input = struct {
    shift: u5,
    gpio: *volatile cpu.Gpio,

    const Self = @This();

    pub fn new(pin: u5) Self {
        var input = IoMap[pin];
        const one: u32 = 1;
        var gpio = get_gpio(input.bank);
        gpio.dataDirection &= ~(one << input.shift);
        get_port(input.bank).controlRegister[input.shift] = cpu.port_pcr_mux(1);

        return Self{ .shift = input.shift, .gpio = gpio };
    }

    pub fn read(self: Self) bool {
        const one: u32 = 1;
        return self.gpio.dataInput == (one << self.shift);
    }
};
