/* f446re_button_counter.s
 * Contar pulsaciones en PC13
 */

.syntax unified
.cpu cortex-m4
.thumb

/* direcciones de registros */
.equ RCC_AHB1ENR, 0x40023830   /* reloj GPIO */
.equ GPIOA_MODER,  0x40020000  /* modo PAx */
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

    /* 3) Inicializar contador en R2 */
    mov   r2, #0                       /* Contador de pulsaciones */

loop:
    /* 4) Leer estado del pulsador en PC13 */
    ldr   r0, =GPIOC_IDR
    ldr   r1, [r0]
    and   r1, r1, #(1 << 13)          /* Aislar bit 13 */
    cmp   r1, #0
    beq   check_release                /* Si no está presionado, ir a check_release */

    /* 5) Incrementar contador si el botón está presionado */
    add   r2, r2, #1                   /* Incrementar contador */
    bl   delay                         /* Llamar a la subrutina de retardo para evitar rebotes */

check_release:
    /* 6) Esperar a que se suelte el botón */
    ldr   r0, =GPIOC_IDR
    ldr   r1, [r0]
    and   r1, r1, #(1 << 13)          /* Aislar bit 13 */
    cmp   r1, #0
    bne   check_release                /* Si sigue presionado, esperar */

    b     loop                        /* Volver al bucle principal */

delay:
    /* Subrutina de retardo simple */
    mov   r3, #100                 /* Valor de retardo */
delay_loop:
    subs  r3, r3, #1                   /* Decrementar contador */
    bne   delay_loop                   /* Repetir hasta que r3 sea 0 */
    bx    lr                           /* Volver de la subrutina */

.size main, .-main
