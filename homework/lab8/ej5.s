/* f446re_shifts.s
 * Programa que utiliza desplazamientos lógicos y aritméticos
 */

.syntax unified
.cpu cortex-m4
.thumb

.text
.global main

main:
    /* Inicializar un valor en R0 */
    mov   r0, #32     /* R0 = 32 (0b00100000) */

    /* Desplazamiento lógico a la izquierda de 3 bits */
    lsl   r0, r0, #3  /* R0 = R0 << 3 (R0 = 256) */

    /* Desplazamiento aritmético a la derecha de 2 bits */
    asr   r0, r0, #2  /* R0 = R0 >> 2 (R0 = 64) */

    b     .           /* Bucle infinito para detener la ejecución */
