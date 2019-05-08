#include <stdint.h>
#include "stm32g0.h"

void enable_clock(void);
void configure_GPIO_clock(void);
void configure_PERIPH_clock(void);
void configure_TIM3(void);
void configure_GPIO_B(void);
void configure_GPIO_C(void);
void delay(void);

void L1_fade_up(void);
void L1_fade_down(void);
void L2_fade_up(void);
void L2_fade_down(void);

void main(void)
{
 //enable_clock();
 configure_GPIO_clock();
 configure_PERIPH_clock();
 configure_GPIO_B();
 configure_GPIO_C();
 configure_TIM3();
 while(1)
 {
  L1_fade_up();
  L1_fade_down();
  L2_fade_up();
  L2_fade_down();
  L1_fade_up();
  L2_fade_up();
  L1_fade_down();
  L2_fade_down();
 }
}

void enable_clock(void)
{
 // TODO: enable PLL and wait for PLLRDY
 RCC_CR = 0x1000000;
 RCC_PLLCFGR = 0x1000 | 0x02;
}

void configure_GPIO_clock(void)
{
 RCC_IOPENR = 0xff;
}

void configure_PERIPH_clock(void)
{
 RCC_APBENR1 = 0x02;
 RCC_APBENR2 = 0x8000;
}

void configure_GPIO_B(void)
{
 GPIOB_AFRL = 0x10;
 GPIOB_OTYPER = 0x00;
 GPIOB_OSPEEDR = 0x00;
 GPIOB_MODER = 0xfffffffb;
}

void configure_GPIO_C(void)
{
 GPIOC_AFRL = 0x1000000;
 GPIOC_OTYPER = 0x00;
 GPIOC_OSPEEDR = 0x00;
 GPIOC_MODER = 0xffffefff;
}

void configure_TIM3(void)
{
 TIM3_CCMR2 = 0x6800;
 TIM3_CCMR1 = 0x68;
 TIM3_CCER = 0x1001;
 TIM3_ARR = 0xffff;
 TIM3_PSC = 0x00;
 TIM3_CCR4 = 0x00; // LED1
 TIM3_CCR1 = 0x00; // LED2
 TIM3_CR1 = 0x01;
}

void L1_fade_up(void)
{
 for(unsigned int x=0x00; x<=0xffff; x++)
 {
  TIM3_CCR4 = x;
  delay();
 }
}

void L1_fade_down(void)
{
 for(int x=0xffff; x>=0; x--)
 {
  TIM3_CCR4 = x;
  delay();
 }
}

void L2_fade_up(void)
{
 for(unsigned int x=0x00; x<=0xffff; x++)
 {
  TIM3_CCR1 = x;
  delay();
 }
}

void L2_fade_down(void)
{
 for(int x=0xffff; x>=0; x--)
 {
  TIM3_CCR1 = x;
  delay();
 }
}

void delay(void)
{
 unsigned int _t = 0x00;
 for(_t = 0; _t < 75; _t++){}
 return;
}
