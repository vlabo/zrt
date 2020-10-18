const c = @cImport({
    @cInclude("functions.h");
});

const uart = @cImport({
    @cInclude("uart.h");
});


fn delay(duration: i32) void {
  var dur : i32 = duration;
  while (dur > 0) {
    var inner : i32 = 72000 / 10;
    while (inner > 0) {
      inner -= 1;
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
      asm volatile ("nop");
    }
    dur -= 1;
  }
}

export fn main() noreturn {

  // Pin 13 (with the onboard LED) in teensy labelling == GPIO Port C, Pin 5
  // Set GPIOC pin 5 to output direction

  uart.uart0_setup_default();

  var pddr align(32) = @intToPtr(*volatile u32, 0x400FF094);
  pddr.* = (1<<5);

  // // Set the MUX on Port C Pin 5 to use GPIO as the source
  var portc_pcr5 align(32) = @intToPtr(*volatile u32, 0x4004B014);
  portc_pcr5.* = ((1 << 8) & 0x700 ) | 0x44;

  var gpioc_psor align(32) = @intToPtr(*volatile u32, 0x400FF084);
  var gpioc_pcor align(32) = @intToPtr(*volatile u32, 0x400FF088);

  while (true) {
    gpioc_psor.* = (1<<5); // Set GPIO C pin 5 (make it HIGH)
    delay(100);
    gpioc_pcor.* = (1<<5); // Clear GPIO C pin 5 (make it LOW)
    delay(100);
    uart.uart0_putchar('a');
  }
}
