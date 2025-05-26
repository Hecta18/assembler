.syntax unified
.cpu cortex-m4
.thumb

.section .data
array: .byte 1,2,3,4

.section .text
.global main

main:

	LDR r0, =array //direccionamiento indirecto
	LDRB r1, [r0] // cargar 1er byte
	add r1, r1, #1
	STRB r1, [r0, #3] // guardar valor r1 en 4to posicion
	bkpt #0 //breakpoint

.end
