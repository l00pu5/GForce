#include <stdint.h>
#include "stm32g0.h"

void enable_clock(void);

void main(void)
{
 //enable_clock();
 while(1) 
 {
  // TODO: enter logic here
 }
}

void enable_clock(void)
{
 // TODO: enable PLL and wait for PLLRDY
 RCC_CR = 0x1000000;
 RCC_PLLCFGR = 0x1000 | 0x02;
}