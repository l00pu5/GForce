.thumb
.syntax unified

.section .vectors
.org 0x00
.word 0x20009000
.word _start + 1

@@@ EQUATES
.equ GPIOB, 0x50000400
.equ OFS_GPIOB_MODER, 0x00
.equ OFS_GPIOB_ODR, 0x14
.equ OFS_GPIOB_OTYPER, 0x04
.equ OFS_GPIOB_OSPEEDR, 0x08
.equ OFS_GPIOB_AFRL, 0x20
.equ OFS_GPIOB_AFRH, 0x24
.equ GPIOC, 0x50000800
.equ OFS_GPIOC_MODER, 0x00
.equ OFS_GPIOC_ODR, 0x14
.equ OFS_GPIOC_OTYPER, 0x04
.equ OFS_GPIOC_OSPEEDR, 0x08
.equ OFS_GPIOC_AFRL, 0x20
.equ OFS_GPIOC_AFRH, 0x24
.equ RCC, 0x40021000
.equ OFS_RCC_IOPENR, 0x34
.equ RCC_IOPENR_GPIOAEN, 0x01
.equ OFS_RCC_AHBENR, 0x38
.equ OFS_RCC_APBENR1, 0x3c
.equ OFS_RCC_APBENR2, 0x40

.equ TIM14, 0x40002000
.equ OFS_TIM14_CR1, 0x00
.equ OFS_TIM14_CCMR1, 0x18
.equ OFS_TIM14_CCER, 0x20
.equ OFS_TIM14_PSC, 0x28
.equ OFS_TIM14_ARR, 0x2c
.equ OFS_TIM14_CCR1, 0x34

.equ TIM3, 0x40000400
.equ OFS_TIM3_CR1, 0x00
.equ OFS_TIM3_CCMR1, 0x18
.equ OFS_TIM3_CCMR2, 0x1c
.equ OFS_TIM3_CCER, 0x20
.equ OFS_TIM3_PSC, 0x28
.equ OFS_TIM3_ARR, 0x2c
.equ OFS_TIM3_CCR1, 0x34
.equ OFS_TIM3_CCR2, 0x38
.equ OFS_TIM3_CCR3, 0x3c
.equ OFS_TIM3_CCR4, 0x40

.section .bss
bss_var: .word 0x00

.section .data
data_var: .word 0x12345678

.section .rodata
.word 0, 0, 0, 0, 0
rodata_var: .word 0x87654321

.text
.global _start
.global _reset
.word _ETEXT
.word _DATA_ROM_START
.word _DATA_RAM_START
.word _DATA_RAM_END
.word _BSS_START
.word _BSS_END

_reset:
_start:
 @@@ init data
 bl init_data
 @@@ init bss
 bl init_bss
 
 bl init_GPIO_clocks
 bl init_TIM_clocks
 bl init_GPIOB
 bl init_GPIOC
 bl init_TIM3
_loop:
 bl BOTH_fade_up
 bl BOTH_fade_down
 bl L1_fade_up
 bl L1_fade_down
 bl L2_fade_up
 bl L2_fade_down
 bl L1_fade_up
 bl L2_fade_up
 bl L1_fade_down
 bl L2_fade_down
 b _loop
.ltorg

BOTH_fade_up:
 push {r0, r1, r2, r3, r4, lr}
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCR4
 ldr r4, =OFS_TIM3_CCR1
 ldr r2, =0x00
 ldr r3, =0xffff
_B_f_u_loop:
 str r2, [r0, r1]
 str r2, [r0, r4]
 bl delay
 adds r2, #1
 cmp r2, r3
 bne _B_f_u_loop
 str r2, [r0, r1]
 str r2, [r0, r4]
 bl delay
 pop {r0, r1, r2, r3, r4, pc}
 bx lr
.ltorg

L1_fade_up:
 push {r0, r1, r2, r3, lr}
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCR4
 ldr r2, =0x00
 ldr r3, =0xffff
_L1_f_u_loop:
 str r2, [r0, r1]
 bl delay
 adds r2, #1
 cmp r2, r3
 bne _L1_f_u_loop
 str r2, [r0, r1]
 bl delay
 pop {r0, r1, r2, r3, pc}
 bx lr
.ltorg

L2_fade_up:
 push {r0, r1, r2, r3, lr}
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCR1
 ldr r2, =0x00
 ldr r3, =0xffff
_L2_f_u_loop:
 str r2, [r0, r1]
 bl delay
 adds r2, #1
 cmp r2, r3
 bne _L2_f_u_loop
 str r2, [r0, r1]
 bl delay
 pop {r0, r1, r2, r3, pc}
 bx lr
.ltorg

BOTH_fade_down:
 push {r0, r1, r2, r3, r4, lr}
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCR4
 ldr r4, =OFS_TIM3_CCR1
 ldr r2, =0xffff
 ldr r3, =0x00
_B_f_d_loop:
 str r2, [r0, r1]
 str r2, [r0, r4]
 bl delay
 subs r2, #1
 cmp r2, r3
 bne _B_f_d_loop
 str r2, [r0, r1]
 str r2, [r0, r4]
 bl delay
 pop {r0, r1, r2, r3, r4, pc}
 bx lr
.ltorg

L1_fade_down:
 push {r0, r1, r2, r3, lr}
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCR4
 ldr r2, =0xffff
 ldr r3, =0x00
_L1_f_d_loop:
 str r2, [r0, r1]
 bl delay
 subs r2, #1
 cmp r2, r3
 bne _L1_f_d_loop
 str r2, [r0, r1]
 bl delay
 pop {r0, r1, r2, r3, pc}
 bx lr
.ltorg

L2_fade_down:
 push {r0, r1, r2, r3, lr}
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCR1
 ldr r2, =0xffff
 ldr r3, =0x00
_L2_f_d_loop:
 str r2, [r0, r1]
 bl delay
 subs r2, #1
 cmp r2, r3
 bne _L2_f_d_loop
 str r2, [r0, r1]
 bl delay
 pop {r0, r1, r2, r3, pc}
 bx lr
.ltorg

init_TIM3:
 push {r0, r1, r2}
 @@@       -> set up capture/compare channels
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCMR2
 ldr r2, =0x6800
 str r2, [r0, r1]
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCMR1
 ldr r2, =0x68
 str r2, [r0, r1]
 @@@       -> enable capture/compare channels
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCER
 ldr r2, =0x1001
 str r2, [r0, r1]
 @@@       -> set up TIMx_ARR
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_ARR
 ldr r2, =0xffff
 str r2, [r0, r1]
 @@@       -> set up TIMx_PSC
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_PSC
 ldr r2, =0x00
 str r2, [r0, r1]
 @@@       -> set up initial duty cycle
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCR4
 ldr r2, =0x00
 str r2, [r0, r1]
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CCR1
 ldr r2, =0x00
 str r2, [r0, r1]
 @@@       -> enable TIMx
 ldr r0, =TIM3
 ldr r1, =OFS_TIM3_CR1
 ldr r2, =0x01
 str r2, [r0, r1]
 pop {r0, r1, r2}
 bx lr
.ltorg

init_GPIO_clocks:
 push {r0, r1, r2}
 ldr r0, =RCC
 ldr r1, =OFS_RCC_IOPENR
 ldr r2, =0xff
 str r2, [r0, r1]
 pop {r0, r1, r2}
 bx lr
.ltorg

init_TIM_clocks:
 push {r0, r1, r2}
 ldr r0, =RCC
 ldr r1, =OFS_RCC_APBENR1
 ldr r2, =0x02
 str r2, [r0, r1]
 ldr r1, =OFS_RCC_APBENR2
 ldr r2, =0x8000
 str r2, [r0, r1]
 pop {r0, r1, r2}
 bx lr
.ltorg

init_GPIOB:
 push {r0, r1, r2}
 @@@ select AF
 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_AFRL
 ldr r2, =0x10
 str r2, [r0, r1]
 @@@ select OTYPER
 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_OTYPER
 ldr r2, =0x00
 str r2, [r0, r1]
 @@@ select OSPEEDR
 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_OSPEEDR
 ldr r2, =0x00
 str r2, [r0, r1]
 @@@ select AF via MODER
 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_MODER
 ldr r2, =0xfffffffb
 str r2, [r0, r1]
 pop {r0, r1, r2}
 bx lr
.ltorg

init_GPIOC:
 push {r0, r1, r2}
 @@@ select AF
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_AFRL
 ldr r2, =0x1000000
 str r2, [r0, r1]
 @@@ select OTYPER
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_OTYPER
 ldr r2, =0x00
 str r2, [r0, r1]
 @@@ select OSPEEDR
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_OSPEEDR
 ldr r2, =0x00
 str r2, [r0, r1]
 @@@ select AF via MODER
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_MODER
 ldr r2, =0xffffefff
 str r2, [r0, r1]
 pop {r0, r1, r2}
 bx lr
.ltorg

init_data:
 movs r1, #0
 b LoopCopyDataInit
CopyDataInit:
 ldr r3, =_DATA_ROM_START
 ldr r3, [r3, r1]
 str r3, [r0, r1]
 adds r1, r1, #4
LoopCopyDataInit:
 ldr r0, =_DATA_RAM_START
 ldr r3, =_DATA_RAM_END
 adds r2, r0, r1
 cmp r2, r3
 bcc CopyDataInit
 bx lr
.ltorg

init_bss:
 ldr r2, =_BSS_START
 b LoopFillZeroBss
FillZeroBss:
 movs r3, #0
 str r3, [r2]
 adds r2, r2, #4
LoopFillZeroBss:
 ldr r3, =_BSS_END
 cmp r2, r3
 bcc FillZeroBss
 bx lr
.ltorg

delay:
 push {r2}
 ldr r2, =80
delay_loop:
 subs r2, r2, #1
 bne delay_loop
 pop {r2}
 bx lr
.ltorg