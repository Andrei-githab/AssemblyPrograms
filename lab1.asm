section .data
    namber1 db "Namber 1: ", 0
    namber2 db "Namber 2: ", 0
    namber3 db "Namber 3: ", 0
    namber4 db "Namber 4: ", 0
    namber5 db "Namber 5: ", 0
    buffer resb 32

section .text
    global _start

_start:
    ; Display "Namber 1: " and read input
    mov eax, 4
    mov ebx, 1
    mov ecx, namber1
    mov edx, 10
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 32
    int 0x80

    ; Display "Namber 2: " and read input
    mov eax, 4
    mov ebx, 1
    mov ecx, namber2
    mov edx, 10
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 32
    int 0x80

    ; Display "Namber 3: " and read input
    mov eax, 4
    mov ebx, 1
    mov ecx, namber3
    mov edx, 10
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 32
    int 0x80

    ; Display "Namber 4: " and read input
    mov eax, 4
    mov ebx, 1
    mov ecx, namber4
    mov edx, 10
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 32
    int 0x80

    ; Display "Namber 5: " and read input
    mov eax, 4
    mov ebx, 1
    mov ecx, namber5
    mov edx, 10
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 32
    int 0x80

    ; Display namber5
    mov eax, 4
    mov ebx, 1
    mov ecx, namber5
    mov edx, 32
    int 0x80

    ; Display namber4
    mov eax, 4
    mov ebx, 1
    mov ecx, namber4
    mov edx, 32
    int 0x80

    ; Display namber3
    mov eax, 4
    mov ebx, 1
    mov ecx, namber3
    mov edx, 32
    int 0x80

    ; Display namber2
    mov eax, 4
    mov ebx, 1
    mov ecx, namber2
    mov edx, 32
    int 0x80

    ; Display namber1
    mov eax, 4
    mov ebx, 1
    mov ecx, namber1
    mov edx, 32
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
    