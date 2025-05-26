.syntax unified
.cpu cortex-m4
.thumb

.section .data
var: .word 50

.section .text
.global main

main:

	MOV R1, #42          // b. Cargue el valor 42 en un registro
	ldr r0, =var        // Cargar direccion de variable en registro (modo indirecto)
    STR R1, [r0]        // c. Almacene dicho valor en la variable “var” 
    LDR R2, [r0]        // d. Lea el valor de “var” a otro registro 

.end
