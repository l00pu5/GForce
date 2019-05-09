#define STACK_TOP 0x20009000
#define WEAK __attribute__ ((weak))

extern unsigned int _ETEXT;
extern unsigned int _DATA_ROM_START;
extern unsigned int _DATA_RAM_START;
extern unsigned int _DATA_RAM_END;
extern unsigned int _BSS_START;
extern unsigned int _BSS_END;

// function prototypes
void init_data(void);
void init_bss(void);
void startup(void);
void main(void);
void HANDLER_Reset(void);

unsigned int* vector_table[] 
__attribute__ ((section(".vectors"))) =
{
 (unsigned int*) STACK_TOP,
 (unsigned int*) HANDLER_Reset /* 0x00000004 : RESET */
 /* 0x00000008 : NMI */
 /* 0x0000000C : HardFault */
 /* 0x00000010 : Reserved */
 /* 0x00000014 : Reserved */
 /* 0x00000018 : Reserved */
 /* 0x0000001C : Reserved */
 /* 0x00000020 : Reserved */
 /* 0x00000024 : Reserved */
 /* 0x00000028 : Reserved */
 /* 0x0000002C : SVCall */
 /* 0x00000030 : Reserved */
 /* 0x00000034 : Reserved */
 /* 0x00000038 : PendSV */
 /* 0x0000003C : SysTick */
 /* 0x00000040 : WWDG */
 /* 0x00000044 : PVD */
 /* 0x00000048 : RTC_TAMPER */
 /* 0x0000004C : FLASH */
 /* 0x00000050 : RCC */
 /* 0x00000054 : EXTI0_1 */
 /* 0x00000058 : EXTI2_3 */
 /* 0x0000005C : EXTI4_15 */
 /* 0x00000060 : UCPD */
 /* 0x00000064 : DMA_Channel1 */
 /* 0x00000068 : DMA_Channel2_3 */
 /* 0x0000006C : DMA_CHannel4_5_5_DMAMUX */
 /* 0x00000070 : ADC_COMP */
 /* 0x00000074 : TIM1_BRK_UP_TRG_COM */
 /* 0x00000078 : TIM1_CC */
 /* 0x0000007C : TIM2 */
 /* 0x00000080 : TIM3 */
 /* 0x00000084 : TIM6_DAC / LPTIM1 */
 /* 0x00000088 : TIM7 / LPTIM2 */
 /* 0x0000008C : TIM14 */
 /* 0x00000090 : TIM15 */
 /* 0x00000094 : TIM16 */
 /* 0x00000098 : TIM17 */
 /* 0x0000009C : I2C1 */
 /* 0x000000A0 : I2C2 */
 /* 0x000000A4 : SPI1 */
 /* 0x000000A8 : SPI2 */
 /* 0x000000AC : USART1 */
 /* 0x000000B0 : USART2 */
 /* 0x000000B4 : USART3 / USART4 / LPUART1 */
 /* 0x000000B8 : CEC */
 /* 0x000000BC : AES / RNG */
};

void init_data(void)
{
 unsigned int* p_data_rom_start = &_DATA_ROM_START;
 unsigned int* p_data_ram_start = &_DATA_RAM_START;
 unsigned int* p_data_ram_end = &_DATA_RAM_END;
 while(p_data_ram_start != p_data_ram_end)
 {
  *p_data_ram_start = *p_data_rom_start;
  p_data_ram_start += 1;
  p_data_rom_start += 1;
 }
}

void init_bss(void) 
{
 unsigned int* p_bss_start = &_BSS_START;
 unsigned int* p_bss_end = &_BSS_END;
 while(p_bss_start != p_bss_end)
 {
  *p_bss_start = 0x00;
  p_bss_start += 1;
 }
}

void startup(void)
{
 init_data();
 init_bss();
 main();
}

WEAK void HANDLER_Reset(void)
{
 main();
}