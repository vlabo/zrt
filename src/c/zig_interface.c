#include "FreeRTOS.h"
#include "task.h"
#include "zig_interface.h"

long rtTaskCreate(void (*task)(void), const char *name, unsigned int priority)
{
    return xTaskCreate(task, name, 256, NULL, priority, NULL);
}

void rtStartSchedular() {
    vTaskStartScheduler();
}

void rtTaskDelay(unsigned int ticks) {
    vTaskDelay(ticks);
}