.global _start
_start:
	mov r0, #20
	mov r1, #4
	mov	r2, #0
	bl dividir
	b stop

dividir:
	div_loop:
		cmp r0,r1
		blt div_done
		sub r0, r0, r1
		add r2, r2, #1
		b div_loop

	div_fin:
		bx lr
	
stop:
	b stop

.end