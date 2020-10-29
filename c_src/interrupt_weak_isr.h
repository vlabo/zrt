#ifndef _INTERRUPT_WEAK_ISR_H_
#define _INTERRUPT_WEAK_ISR_H_

#ifndef _INTERRUPT_TABLE_SETUP_
#error "This file should only be included where the interrupt vector table is defined"
#endif

#include "interrupt.h"

/*
 * Interrupt service routine defaults.
 *
 * This header defines weak symbols for all ISRs and should therefore only be 
 * included by startup.c
 */

#endif
