MEMORY {
 FLASH : ORIGIN = 0x08000000, LENGTH = 128K
 RAM : ORIGIN = 0x20000000, LENGTH = 36K
}

SECTIONS {
 .text : 
 {
  *(.vectors)
  *(.text)
  *(.text*)
  _ETEXT = .;
 } > FLASH
 
 .rodata :
 {
  *(.rodata)
  *(.rodata*)
 } > FLASH

 _DATA_ROM_START = .;
 .data : AT (_DATA_ROM_START)
 {
  _DATA_RAM_START = .;
  *(.data)
  *(.data*)
  _DATA_RAM_END = .;
 } > RAM

 _BSS_START = .;
 .bss : 
 {
  *(.bss)
  *(.bss*)
 } > RAM
 _BSS_END = .;
}