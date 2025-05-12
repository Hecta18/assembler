.global _start
_start:
	
	mov r0, #20
	mov r1, #4
	mov r3, #0
	bl mult
	b stop

mult:
	mul_loop:
		cmp r1,#0
		beq mul_done
		add r3, r3, r0
		sub r1, r1, #1
		b mul_loop

	mul_done:
		bx lr
	
stop:
	b stop

.end