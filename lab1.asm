section .data  ; Секция для данных  
    input db "Input:", 0xA     ; Переменная db - date.byte (Под каждый символ байт), 0xA - переход на новую строку
    inputlen equ $ - input    ;equ - определение длина переменной, inputlen - переменная, $ -текущее место в памяти (H - текущее место в паямти) отсюда и длина
    fnum db "N1:",  
    fnumlen equ $ - fnum    
    snum db "N2:",  
    snumlen equ $ - snum   
    tnum db "N3:",  
    tnumlen equ $ - tnum   
    output db "Output", 0xA   ; Переменная db - date.byte (Под каждый символ байт), 0xA - переход на новую строку
    outputlen equ $ - output  ;equ - определение длина переменной, inputlen - переменная, $ -текущее место в памяти (H - текущее место в паямти) отсюда и длина
   


section .bss ; Секция объявления переменных ( 5 - размерность в байтах)
    num1 resb 5
    num2 resb 5
    num3 resb 5

section .text ; Cекция кода 
    global _start       ; Объявление global_start указывает ядру, с чего начинается выполнение программы.

_start:
;Вывод в консоль "Input:"
    mov eax, 4          ; 4 - номер системного вызова (sys_write)
    mov ebx, 1          ; 1 - файловый дескриптор (stdout) |  Ко всем потокам ввода-вывода можно получить доступ через так называемые файловые дескрипторы.
    mov ecx, input      ; Переносим переменную input в ecx
    mov edx, inputlen   ; Переносим длину сообщения для вывода в edx
    int 0x80            ; Вызов ядра
;  num1
    
    ; Вывод в консоль "N1:"
    mov eax, 4          ; 4 - номер системного вызова (sys_write)
    mov ebx, 1          ; 1 - файловый дескриптор (stdout) |  Ко всем потокам ввода-вывода можно получить доступ через так называемые файловые дескрипторы.
    mov ecx, fnum      ; Переносим переменную input в ecx
    mov edx, fnumlen   ; Переносим длину сообщения для вывода в edx
    int 0x80            ; Вызов ядра
    

    ; Чтение num1
    mov eax, 3          ; 3 - номер системного вызова  (sys_read)
    mov ebx, 2          ; 2 - файловый дескриптор (stdin)
    mov ecx, num1       ; Ссылка на переменную в которую запишем число 
    mov edx, 5          ; 5 - длина сообщения 
    int 0x80            ; call kernel


    
;  num2
    ; Вывод в консоль "N2:"
    mov eax, 4          
    mov ebx, 1         
    mov ecx, snum       
    mov edx, snumlen    
    int 0x80            
    
    ; Чтение num2
    mov eax, 3          ; system call number (sys_read)
    mov ebx, 2          ; file descriptor (stdin)
    mov ecx, num2       ; address to write
    mov edx, 5          ; message length
    int 0x80            ; call kernel


    
; num3
    ; Вывод в консоль "N3:"
    mov eax, 4          
    mov ebx, 1          
    mov ecx, tnum      
    mov edx, tnumlen   
    int 0x80            
    
  

    ; Чтение num3
    mov eax, 3          
    mov ebx, 2          
    mov ecx, num3       
    mov edx, 5          
    int 0x80            


; Вывод "Output:"
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, outputlen
    int 0x80
   
    ; Вывод num3 
    mov eax, 4
    mov ebx, 1
    mov ecx, num3
    mov edx, 5
    int 0x80

    ; Вывод num2 
    mov eax, 4
    mov ebx, 1
    mov ecx, num2
    mov edx, 5
    int 0x80

    ; Вывод num1 
    mov eax, 4
    mov ebx, 1
    mov ecx, num1
    mov edx, 5
    int 0x80

; Завершение прошграммы
    mov eax, 1
    int 0x80
