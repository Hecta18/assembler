.global _start
_start:
	//carga y resta
	mov r1, #0xC0
	mov r2, #0x1F
	sub r3, r1, r2

	//tipos de resta
	RSB r0, r1, r2
	SUB r0, r2, r1

	//resultado 0
	mov r7, #0xA
	mov r4, #0x0
	MUL r7, r1, r4
	cpy r7, r4
	rev r7, r4
	add r7, r4

	//not en un solo registro
	mov r0, #0xa
	mvn r0, r0

	//modularizacion
	extern module_sum