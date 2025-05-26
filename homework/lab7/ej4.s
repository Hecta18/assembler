.syntax unified
.cpu cortex-m4
.thumb

.section .data
array: .word 5, 10, 5, 20   // Definición del arreglo
result: .space 16            // Reserva espacio para almacenar resultados (4 elementos de 4 bytes)

.section .text
.global main

main:
    LDR R0, =array           // Cargar la dirección base del arreglo en R0
    LDR R1, [R0]             // Cargar el primer elemento del arreglo en R1
    MOV R2, #0               // Inicializar índice de resultado

loop:
    LDR R3, [R0, R2, LSL #2] // Cargar elemento actual del arreglo
    CMP R3, R1               // Comparar con el primer elemento
    BEQ store_one            // Si son iguales, almacenar 1
    MOV R4, #0               // Almacenar 0 en R4
    B store_result           // Saltar a almacenar el resultado

store_one:
    MOV R4, #1               // Almacenar 1 en R4

store_result:
    LDR R5, =result          // Cargar la dirección de 'result' en R5
    STR R4, [R5, R2]         // Almacenar el valor de R4 en 'result' en la posición R2

    ADD R2, R2, #1           // Incrementar índice
    CMP R2, #4               // Comparar con el tamaño del arreglo
    BLT loop                 // Si es menor, repetir

    BKPT #0                  // Fin del programa

.end
