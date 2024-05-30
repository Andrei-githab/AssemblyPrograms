section .data
    prompt db "Enter a number: ", 0
    result db "Result: ", 0

section .bss
    number resd 1

section .text
    global _start

_start:
    ; Prompt for input
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, 15
    int 0x80

    ; Read input from console
    mov eax, 3
    mov ebx, 0
    mov ecx, number
    mov edx, 4
    int 0x80

    ; Convert the input to decimal
    mov eax, [number]
    sub eax, '0'

    ; Convert to hexadecimal
    mov ebx, 16
    xor edx, edx
    div ebx
    add edx, '0'
    cmp edx, '9'
    jle hex_digit
    add edx, 7

hex_digit:
    push edx

    ; Convert to binary
    mov ebx, 2
    xor edx, edx
    div ebx
    add edx, '0'

    push edx

    ; Convert to octal
    mov ebx, 8
    xor edx, edx
    div ebx
    add edx, '0'

    push edx

    ; Print the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 8
    int 0x80

    pop eax ; Pop octal digit
    int 0x80

    pop eax ; Pop binary digit
    int 0x80

    pop eax ; Pop hexadecimal digit
    int 0x80

exit:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
