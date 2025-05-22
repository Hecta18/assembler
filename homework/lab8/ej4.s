/* f446re_arithmetic.s
 * Subrutina para realizar la operación (R1 + R2) - (R3 * 4)
 */

.syntax unified
.cpu cortex-m4
.thumb

.text
.global main

main:
    /* Inicializar registros R1, R2 y R3 con valores inmediatos */
    mov   r1, #5      /* R1 = 5 */
    mov   r2, #10     /* R2 = 10 */
    mov   r3, #3      /* R3 = 3 */

    /* Llamar a la subrutina */
    bl    arithmetic_operation

    b     .           /* Bucle infinito para detener la ejecución */

arithmetic_operation:
    /* R0 = R1 + R2 */
    adds  r0, r1, r2  /* Sumar R1 y R2, resultado en R0 */

    /* R3 * 4 */
    lsl   r3, r3, #2  /* Desplazamiento lógico a la izquierda de 2 bits (R3 * 4) */

    /* R0 = R0 - R3 */
    subs  r0, r0, r3  /* Restar R3 de R0 */

    bx    lr          /* Regresar de la subrutina */
