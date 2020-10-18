#ifndef _UART_H_
#define _UART_H_

void uart0_setup_default();
void uart0_putchar(char ch);
void uart0_putline(char * str);
/*
 * Convenience function to setup UART0 on pins 0 and 1 with 115200 baud
 */

#endif
