@echo off
arm-none-eabi-gcc -O0 -c -g -mcpu=cortex-m0plus -mthumb -o main.o main.c
arm-none-eabi-gcc -O0 -c -g -mcpu=cortex-m0plus -mthumb -o startup.o startup.c
arm-none-eabi-ld -Tstm32g0.ld -o firmware.elf startup.o main.o
arm-none-eabi-objcopy -O binary firmware.elf firmware.bin

arm-none-eabi-objdump -h firmware.elf
arm-none-eabi-nm --numeric-sort firmware.elf
arm-none-eabi-size firmware.elf
arm-none-eabi-objdump --disassemble startup.o
arm-none-eabi-objdump --disassemble main.o
arm-none-eabi-objdump --syms startup.o
arm-none-eabi-objdump --syms main.o
arm-none-eabi-nm startup.o
arm-none-eabi-nm main.o
arm-none-eabi-objdump --disassemble firmware.elf
arm-none-eabi-objdump --disassemble-all firmware.elf
arm-none-eabi-objdump -h firmware.elf
arm-none-eabi-objdump -S firmware.elf
pause