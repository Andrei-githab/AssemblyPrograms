section .data
    input db "Qeb qorqe fp pljbtebob lrq qebob jxvyb", 0
    key equ 3                
    input2 db "VGhlIHRydXRoIGlzIHNvbWV3aGVyZSBvdXQgdGhlcmUgbWF5YmU=", 0
    num1 db 5
    input4 db "Try to find the truth in this code", 0
    num2 db 3
    input3 db "\u0054\u0068\u0065\u0020\u0074\u0072\u0075\u0074\u0068\u0020\u0069\u0073\u0020\u0073\u006f\u006d\u0065\u0077\u0068\u0065\u0072\u0065\u0020\u006f\u0075\u0074\u0020\u0074\u0068\u0065\u0072\u0065\u0020\u006d\u0061\u0079\u0062\u0065", 0

section .bss
    fatality resb 128
    enkript resb 128     
    dekript resb 128
    sekret resb 50

section .text
    global _start

_start:

    xor eax, eax
    jmp sraprogram

egx:
    xor ebx, ebx
    
    jmp main

    xor ecx, ecx
    mov ecx, input4
    xor edx, edx

main_functionale:
    jmp startionion

startionion:
    mov ecx, input          
    mov edx, 0               
    mov esi, fatality       

fanc_loop:
    mov al, [ecx + edx]
    cmp al, 0
    je end_fuct
    add al, key
    cmp al, 'z'
    jbe store_char
    sub al, 26

store_char:
    mov [esi + edx], al
    inc edx
    jmp verno

verno:
    jmp fanc_loop

end_fuct:
    mov eax, 4
    mov ebx, 1
    mov ecx, fatality
    mov edx, edx
    int 0x80

    xor eax, eax
    xor ebx, ebx

    mov eax, 1
    xor ebx, ebx
    int 0x80

sraprogram:
    xor eax, input2
    xor eax, 0
    jmp egx

main:
    lea ax, [eax+eax+09073b000h]
    mov ecx, $+0xc
    lea ax, [eax+eax+09073b000h]
    mov ecx, $+0xc
    lea ax, [eax+eax+09042b000h]
    mov ecx, $+0xc
    lea ax, [eax+eax+09065b000h]
    mov ecx, $+0xc
    lea ax, [eax+eax+09073b000h]
    mov ecx, $+0xc
    lea ax, [eax+eax+09074b000h]
    mov ecx, $+0xc
    lea ax, [eax+eax+09021b000h]
    xor ecx, ecx
    xor ecx, ecx
    jmp main_functionale