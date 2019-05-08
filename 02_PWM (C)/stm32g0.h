#ifndef STM32G0_H
#define STM32G0_H

#include <stdint.h>

#define RCC 0x40021000
#define RCC_CR (*(volatile uint32_t *) (RCC + 0x00))
#define RCC_CR_PLLON 0x1000000
#define RCC_IOPENR (*(volatile uint32_t *) (RCC + 0x34))
#define RCC_IOPENR_GPIOA 0x01
#define RCC_IOPENR_GPIOB 0x02
#define RCC_IOPENR_GPIOC 0x04
#define RCC_IOPENR_GPIOD 0x08
#define RCC_IOPENR_GPIOF 0x20
#define RCC_PLLCFGR (*(volatile uint32_t *) (RCC + 0x0c))
#define RCC_AHBENR (*(volatile uint32_t *) (RCC + 0x38))
#define RCC_APBENR1 (*(volatile uint32_t *) (RCC + 0x3c))
#define RCC_APBENR2 (*(volatile uint32_t *) (RCC + 0x40))

#define GPIOA 0x50000000
#define GPIOB 0x50000400
#define GPIOB_MODER (*(volatile uint32_t *) (GPIOB + 0x00))
#define GPIOB_ODR (*(volatile uint32_t *) (GPIOB + 0x14))
#define GPIOB_OTYPER (*(volatile uint32_t *) (GPIOB + 0x04))
#define GPIOB_OSPEEDR (*(volatile uint32_t *) (GPIOB + 0x08))
#define GPIOB_AFRL (*(volatile uint32_t *) (GPIOB + 0x20))
#define GPIOB_AFRH (*(volatile uint32_t *) (GPIOB + 0x24))
#define GPIOC 0x50000800
#define GPIOC_MODER (*(volatile uint32_t *) (GPIOC + 0x00))
#define GPIOC_ODR (*(volatile uint32_t *) (GPIOC + 0x14))
#define GPIOC_OTYPER (*(volatile uint32_t *) (GPIOC + 0x04))
#define GPIOC_OSPEEDR (*(volatile uint32_t *) (GPIOC + 0x08))
#define GPIOC_AFRL (*(volatile uint32_t *) (GPIOC + 0x20))
#define GPIOC_AFRH (*(volatile uint32_t *) (GPIOC + 0x24))
#define GPIOD 0x50000c00
#define GPIOF 0x50001400

#define TIM3 0x40000400
#define TIM3_CR1 (*(volatile uint32_t *) (TIM3 + 0x00))
#define TIM3_CCMR1 (*(volatile uint32_t *) (TIM3 + 0x18))
#define TIM3_CCMR2 (*(volatile uint32_t *) (TIM3 + 0x1c))
#define TIM3_CCER (*(volatile uint32_t *) (TIM3 + 0x20))
#define TIM3_PSC (*(volatile uint32_t *) (TIM3 + 0x28))
#define TIM3_ARR (*(volatile uint32_t *) (TIM3 + 0x2c))
#define TIM3_CCR1 (*(volatile uint32_t *) (TIM3 + 0x34))
#define TIM3_CCR2 (*(volatile uint32_t *) (TIM3 + 0x38))
#define TIM3_CCR3 (*(volatile uint32_t *) (TIM3 + 0x3c))
#define TIM3_CCR4 (*(volatile uint32_t *) (TIM3 + 0x40))

#endif