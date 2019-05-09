.thumb
.syntax unified

.section .vectors
.org 0x00
.word 0x20009000
.word _start + 1

@@@ EQUATES
@@@ TODO: define equates here

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
_loop:
 @@@ TODO: enter code here
 b _loop
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
