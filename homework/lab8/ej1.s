/* f446re_led.s
 * Encender LED en PA5
 */

.syntax unified
.cpu cortex-m4
.thumb

/* direcciones de registros */
.equ RCC_AHB1ENR, 0x40023830   /* reloj GPIO */
.equ GPIOA_MODER,  0x40020000  /* modo PAx */
.equ GPIOA_BSRR,   0x40020018   /* set/reset PAx */

.text
.global main

main:
    /* 1) Habilitar reloj AHB1 para GPIOA */
    ldr   r0, =RCC_AHB1ENR
    ldr   r1, [r0]
    orr   r1, r1, #(1 << 0)  /* Habilitar GPIOA */
    str   r1, [r0]

    /* 2) Configurar PA5 como salida general (MODER5 = 0b01) */
    ldr   r0, =GPIOA_MODER
    ldr   r1, [r0]
    bic   r1, r1, #(0x3 << (5 * 2))    /* Limpiar bits de MODER5 */
    orr   r1, r1, #(0x1 << (5 * 2))    /* Configurar PA5 como salida */
    str   r1, [r0]

    /* 3) Encender el LED en PA5 */
    ldr   r0, =GPIOA_BSRR
    mov   r1, #(1 << 5)               /* BSRR low half sets pins */
    str   r1, [r0]

    /* Bucle infinito */
loop:
    b loop  /* Mantener el programa en un bucle infinito */

.size main, .-main
