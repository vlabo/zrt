
#ifndef INC_FREERTOS_H
#define INC_FREERTOS_H

#include <stddef.h>
#include <stdint.h>

typedef void (* TaskFunction_t)( void * );

#define pdFALSE                                  ( ( BaseType_t ) 0 )
#define pdTRUE                                   ( ( BaseType_t ) 1 )

#define configASSERT(a)

#define configCPU_CLOCK_HZ				( 72000000 )
#define configTICK_RATE_HZ				( ( TickType_t ) 1000 )

#define configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY	5
#define configPRIO_BITS       		                    4        /* 15 priority levels */

#define configLIBRARY_LOWEST_INTERRUPT_PRIORITY			0xf
#define configKERNEL_INTERRUPT_PRIORITY 		( configLIBRARY_LOWEST_INTERRUPT_PRIORITY << (8 - configPRIO_BITS) )
#define configMAX_SYSCALL_INTERRUPT_PRIORITY 	( configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY << (8 - configPRIO_BITS) )

#include "portmacro.h"

#endif /* INC_FREERTOS_H */
