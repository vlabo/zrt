MEMORY
{
    rom : ORIGIN = 0x00000000, LENGTH = 0x40000
    ram : ORIGIN = 0x20000000, LENGTH = 0x4000
}

SECTIONS
{
    .text : { 
        *(.text*)
        *(.rodata*) 
    } > rom = 0xff

    .ARM.exidx : {
        __exidx_start = .;
        *(.ARM.exidx* .gnu.linkonce.armexidx.*)
        __exidx_end = .;
    } >rom

    .bss : { *(.bss*) } > ram

    .data : {
        . = ALIGN(4);
        *(.data*)
        . = ALIGN(4);
    } > ram

    .bss : {
        . = ALIGN(4);
        _sbss = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } > ram

}