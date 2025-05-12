section .data
    ; Aquí declaramos variables y datos inicializados
    message db "Hola, mundo!", 0    ; Cadena de texto con terminador nulo

section .bss
    ; Aquí se reservan variables no inicializadas
    temp resb 1                     ; Reservar 1 byte para una variable

section .text
    global _start                   ; Punto de entrada del programa

_start:
    ; Mostrar "Hola, mundo!" en la pantalla (sistema operativo Linux)
    mov eax, 4                      ; Código de sistema para 'write'
    mov ebx, 1                      ; Descriptor de archivo (1 = stdout)
    mov ecx, message                ; Dirección del mensaje a imprimir
    mov edx, 13                     ; Longitud del mensaje
    int 0x80                        ; Llamada al sistema

    ; Salir del programa
    mov eax, 1                      ; Código de sistema para 'exit'
    xor ebx, ebx                    ; Código de salida (0)
    int 0x80                        ; Llamada al sistema

