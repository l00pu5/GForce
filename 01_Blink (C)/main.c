#include <stdint.h>
#include "stm32g0.h"

void enable_clock(void);
void configure_GPIO(void);
void delay(void);

void main(void)
{
 //enable_clock();
 configure_GPIO();
 while(1)
 {
  GPIOB_ODR = 0x00;
  GPIOC_ODR = 0x40;
  delay();
  GPIOB_ODR = 0x02;
  GPIOC_ODR = 0x00;
  delay();
 }
}

void enable_clock(void)
{
 // TODO: enable PLL and wait for PLLRDY
 RCC_CR = 0x1000000;
 RCC_PLLCFGR = 0x1000 | 0x02;
}

void configure_GPIO(void)
{
 RCC_IOPENR = 0x0f;
 GPIOB_MODER = 0xfffffff7;
 GPIOB_OTYPER = 0x00;
 GPIOB_OSPEEDR = 0x00;
 GPIOC_MODER = 0xffffdfff;
 GPIOC_OTYPER = 0x00;
 GPIOC_OSPEEDR = 0x00;
}

void delay(void)
{
 unsigned int _t = 0x00;
 for(_t = 0; _t < 200000; _t++){}
 return;
}
