section .date                                  ;секция с переменнымиым 
    message db "Hello!!!!", 0xA                ;0xA - символ новой строки 
    len equ $ - message                        ;equ - длина message для вывод, len - переменная, $ -текущее место в памяти (H - текущее место в паямти) отсюда и длина


section .text                                  ; Секция с выполняемым кодом

global _start                                  
_start:                                        

    mov eax, 4                                 ; system call number (sys_write)
    mov ebx, 1                                 ; file descriptor (stdout)
    mov ecx, message                           ; message to write
    mov edx, len                               ; message length
    int 0x80                                   ; call kernel


    mov eax, 1
    int 0x80