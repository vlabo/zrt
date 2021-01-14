#ifndef TEST_H
#define TEST_H

long rtTaskCreate(void (*task)(void), const char *name, unsigned int priority);
void rtStartSchedular();
void rtTaskDelay(unsigned int ticks);

#endif