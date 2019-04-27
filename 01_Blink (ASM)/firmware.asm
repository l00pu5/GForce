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
.equ GPIOC, 0x50000800
.equ OFS_GPIOC_MODER, 0x00
.equ OFS_GPIOC_ODR, 0x14
.equ OFS_GPIOC_OTYPER, 0x04
.equ OFS_GPIOC_OSPEEDR, 0x08
.equ RCC, 0x40021000
.equ OFS_RCC_IOPENR, 0x34

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
 ldr r0, =RCC
 ldr r1, =OFS_RCC_IOPENR
 ldr r2, =0x0f
 str r2, [r0, r1]

 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_MODER
 ldr r2, =0xfffffff7
 str r2, [r0, r1]

 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_OTYPER
 ldr r2, =0x00
 str r2, [r0, r1]

 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_OSPEEDR
 ldr r2, =0x00
 str r2, [r0, r1]
 
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_MODER
 ldr r2, =0xffffdfff
 str r2, [r0, r1]
 
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_OSPEEDR
 ldr r2, =0x00
 str r2, [r0, r1]
 
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_OTYPER
 ldr r2, =0x00
 str r2, [r0, r1]

 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_ODR
 ldr r2, =0x02
 str r2, [r0, r1]
 
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_ODR
 ldr r2, =0x40
 str r2, [r0, r1]
 
 bl kill_all_LEDs
 bl delay
_loop:
 bl set_LED_01
 bl delay
 bl kill_LED_01
 bl set_LED_02
 bl delay
 bl kill_LED_02
 b _loop
.ltorg

kill_all_LEDs:
 push {r0, r1, r2}
 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_ODR
 ldr r2, =0x00
 str r2, [r0, r1]
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_ODR
 ldr r2, =0x00
 str r2, [r0, r1]
 pop {r0, r1, r2}
 bx lr
 .ltorg
 
kill_LED_01:
 push {r0, r1, r2}
 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_ODR
 ldr r2, =0x00
 str r2, [r0, r1]
 pop {r1, r2, r3}
 bx lr
 .ltorg
 
kill_LED_02:
 push {r0, r1, r2}
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_ODR
 ldr r2, =0x00
 str r2, [r0, r1]
 pop {r1, r2, r3}
 bx lr
 .ltorg
 
set_LED_01:
 push {r0, r1, r2}
 ldr r0, =GPIOB
 ldr r1, =OFS_GPIOB_ODR
 ldr r2, =0x02
 str r2, [r0, r1]
 pop {r0, r1, r2}
 bx lr
 .ltorg
 
set_LED_02:
 push {r0, r1, r2}
 ldr r0, =GPIOC
 ldr r1, =OFS_GPIOC_ODR
 ldr r2, =0x40
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
 ldr r2, =500000
delay_loop:
 subs r2, r2, #1
 bne delay_loop
 pop {r2}
 bx lr
.ltorg
