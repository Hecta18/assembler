/* f446re_button_led.s
 * Pulsador en PC13 → LED en PA5
 */

.syntax unified
.cpu cortex-m4
.thumb

/* direcciones de registros */
.equ RCC_AHB1ENR, 0x40023830   /* reloj GPIO */
.equ GPIOA_MODER,  0x40020000  /* modo PAx */
.equ GPIOA_BSRR,   0x40020018   /* set/reset PAx */
.equ GPIOC_IDR,    0x40020810   /* lectura PCx */

.text
.global main
main:
    /* 1) Habilitar reloj AHB1 para GPIOA (bit 0) y GPIOC (bit 2) */
    ldr   r0, =RCC_AHB1ENR
    ldr   r1, [r0]
    orr   r1, r1, #((1 << 0) | (1 << 2))  /* Habilitar GPIOA y GPIOC */
    str   r1, [r0]

    /* 2) Configurar PA5 como salida general (MODER5 = 0b01) */
    ldr   r0, =GPIOA_MODER
    ldr   r1, [r0]
    bic   r1, r1, #(0x3 << (5 * 2))    /* Limpiar bits de MODER5 */
    orr   r1, r1, #(0x1 << (5 * 2))    /* Configurar PA5 como salida */
    str   r1, [r0]
    b	  turn_off

loop:
    /* 3) Leer estado del pulsador en PC13 */
    ldr   r0, =GPIOC_IDR
    ldr   r1, [r0]
    and   r1, r1, #(1 << 13)          /* Aislar bit 13 */
    cmp   r1, #0
    beq   turn_off                 /* Si no está presionado, ir a turn_off */

turn_on:
    /* 4b) Si no, poner PA5 = 0 (LED OFF) */
    ldr   r0, =GPIOA_BSRR
    mov   r1, #(1 << (5 + 16))        /* BSRR high half resets pins */
    str   r1, [r0]
    b     loop                        /* Volver al bucle principal */

turn_off:
    /* 4a) Si está presionado, poner PA5 = 1 (LED ON) */
    ldr   r0, =GPIOA_BSRR
    mov   r1, #(1 << 5)               /* BSRR low half sets pins */
    str   r1, [r0]
    b     loop                        /* Volver al bucle principal */

.size main, .-main