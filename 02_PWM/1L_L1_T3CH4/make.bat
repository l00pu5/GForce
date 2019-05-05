@echo off

arm-none-eabi-as -mcpu=cortex-m0plus -mthumb firmware.asm -o firmware.o
arm-none-eabi-ld -T stm32g0.ld -nostartfiles -v -o firmware.elf firmware.o
arm-none-eabi-objcopy -O binary firmware.elf firmware.bin
arm-none-eabi-objcopy -O ihex firmware.elf firmware.hex

arm-none-eabi-size firmware.elf
arm-none-eabi-objdump --disassemble firmware.o
arm-none-eabi-objdump --syms firmware.o
arm-none-eabi-nm firmware.o
arm-none-eabi-objdump --disassemble firmware.elf
arm-none-eabi-objdump --disassemble-all firmware.elf
arm-none-eabi-objdump -h firmware.elf
arm-none-eabi-objdump -S firmware.elf

pause