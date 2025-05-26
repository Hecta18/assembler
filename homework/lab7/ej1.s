.syntax unified
.cpu cortex-m4
.thumb

.text
.global main

main:
MOV R0, #10
    // a. Cargue el valor 10 al registro 0 (modo inmediato)
    MOV R1, R0
    // b. Transfiera valores entre el registro 1 y el registro 0 (modo de registro)
    ADD R2, R1, R0
    // c. Realice una operación aritmética (suma) entre ellos (modo inmediato)
.end