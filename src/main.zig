const mk20dx256 = @cImport({
  @cInclude("mk20dx256.h");
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

const UART_MemMap = struct {
  BDH: u8,                                     // < UART Baud Rate Registers:High, offset: 0x0
  BDL: u8,                                     // < UART Baud Rate Registers: Low, offset: 0x1
  C1: u8,                                      // < UART Control Register 1, offset: 0x2
  C2: u8,                                      // < UART Control Register 2, offset: 0x3
  S1: u8,                                      // < UART Status Register 1, offset: 0x4
  S2: u8,                                      // < UART Status Register 2, offset: 0x5
  C3: u8,                                      // < UART Control Register 3, offset: 0x6
  D: u8,                                       // < UART Data Register, offset: 0x7
  MA1: u8,                                     // < UART Match Address Registers 1, offset: 0x8
  MA2: u8,                                     // < UART Match Address Registers 2, offset: 0x9
  C4: u8,                                      // < UART Control Register 4, offset: 0xA
  C5: u8,                                      // < UART Control Register 5, offset: 0xB
  ED: u8,                                      // < UART Extended Data Register, offset: 0xC
  MODEM: u8,                                   // < UART Modem Register, offset: 0xD
  IR: u8,                                      // < UART Infrared Register, offset: 0xE
  RESERVED_0: [1]u8,
  PFIFO: u8,                                   // < UART FIFO Parameters, offset: 0x10
  CFIFO: u8,                                   // < UART FIFO Control Register, offset: 0x11
  SFIFO: u8,                                   // < UART FIFO Status Register, offset: 0x12
  TWFIFO: u8,                                  // < UART FIFO Transmit Watermark, offset: 0x13
  TCFIFO: u8,                                  // < UART FIFO Transmit Count, offset: 0x14
  RWFIFO: u8,                                  // < UART FIFO Receive Watermark, offset: 0x15
  RCFIFO: u8,                                  // < UART FIFO Receive Count, offset: 0x16
  RESERVED_1: [1]u8,
  C7816: u8,                                   // < UART 7816 Control Register, offset: 0x18
  IE7816: u8,                                  // < UART 7816 Interrupt Enable Register, offset: 0x19
  IS7816: u8,                                  // < UART 7816 Interrupt Status Register, offset: 0x1A
  WP7816_type: u8,
  // union {                                          /* offset: 0x1B */
  //   uint8_t WP7816_T_TYPE0;                          /**< UART 7816 Wait Parameter Register, offset: 0x1B */
  //   uint8_t WP7816_T_TYPE1;                          /**< UART 7816 Wait Parameter Register, offset: 0x1B */
  // };
  WN7816: u8,                                  // < UART 7816 Wait N Register, offset: 0x1C
  WF7816: u8,                                  // < UART 7816 Wait FD Register, offset: 0x1D
  ET7816: u8,                                  // < UART 7816 Error Threshold Register, offset: 0x1E
  TL7816: u8,                                  // < UART 7816 Transmit Length Register, offset: 0x1F
};

fn port_pcr_mux(comptime x: comptime_int) comptime_int {
    return (x << mk20dx256.PORT_PCR_MUX_SHIFT) & mk20dx256.PORT_PCR_MUX_MASK;
}

fn uart_bdh_sbr(comptime x: comptime_int) comptime_int {
  return (x << mk20dx256.UART_BDH_SBR_SHIFT) & mk20dx256.UART_BDH_SBR_MASK;
}

fn uart_bdl_sbr(comptime x: comptime_int) comptime_int {
  return (x << mk20dx256.UART_BDL_SBR_SHIFT) & mk20dx256.UART_BDL_SBR_MASK;
}

fn uart_c4_brfa(comptime x: comptime_int) comptime_int {
  return (x << mk20dx256.UART_C4_BRFA_SHIFT) & mk20dx256.UART_C4_BRFA_MASK;
}

fn uart_putchar(base: *volatile UART_MemMap, ch: u8) void {
  // Wait until space is available
  while((base.S1 & mk20dx256.UART_S1_TDRE_MASK) == 0) {}

  // Write character
  base.D = ch;
}

export fn main() noreturn {

  var pin0_port_pcr = @intToPtr(*volatile u32, 0x4004A040);
  pin0_port_pcr.* = port_pcr_mux(3);

  var pin1_port_pcr = @intToPtr(*volatile u32, 0x4004A044);
  pin1_port_pcr.* = port_pcr_mux(3);

  var base = @intToPtr(*volatile UART_MemMap, 0x4006A000);

  var sim_scgc4 align(32) = @intToPtr(*volatile u32, 0x40048034);
  sim_scgc4.* |= mk20dx256.SIM_SCGC4_UART0_MASK;


  // Set defaults (8bit no parity)
  base.C1 = 0;

  // Set the baud rate. This has 3 components:
  //  BDH = Contains interrupt enable bits and the high 5 bits of the divisor
  //  BDL = Contains the low 8 bits of the divisor
  //  C4_BRFA = The fine adjust value
  //
  //  tx baud = module clock / (16 * (divisor + BRFA/32))
  const baud: comptime_int = 115200;
  const divisor: comptime_int = 72000000 / (baud * 16);
  const brfa: comptime_int = (2*72000000) / baud - divisor * 32;

  base.BDH = uart_bdh_sbr(divisor >> 8);
  base.BDL = uart_bdl_sbr(divisor);
  base.C4 = uart_c4_brfa(brfa);

  // Enable Tx
  base.C2 = mk20dx256.UART_C2_TE_MASK;

  var pddr align(32) = @intToPtr(*volatile u32, 0x400FF094);
  pddr.* = (1<<5);

  // // Set the MUX on Port C Pin 5 to use GPIO as the source
  var portc_pcr5 align(32) = @intToPtr(*volatile u32, 0x4004B014);
  portc_pcr5.* = port_pcr_mux(1) | mk20dx256.PORT_PCR_SRE_MASK | mk20dx256.PORT_PCR_DSE_MASK;

  var gpioc_psor align(32) = @intToPtr(*volatile u32, 0x400FF084);
  var gpioc_pcor align(32) = @intToPtr(*volatile u32, 0x400FF088);

  while (true) {
    gpioc_psor.* = (1<<5); // Set GPIO C pin 5 (make it HIGH)
    delay(200);
    gpioc_pcor.* = (1<<5); // Clear GPIO C pin 5 (make it LOW)
    delay(200);
    uart_putchar(base, 'a');
  }
}
