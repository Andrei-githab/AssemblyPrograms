; Программа, которая предлагает пользователю ввести несколько символов, сохраняет их в переменных и затем выводит в обратном порядке с соответствующими надписями.

section .data  ; Секция для данных  
    input db "Input numbers:", 0xA ; Переменная db - date.byte (Под каждый символ байт), 0xA - переход на новую строку
    inputlen equ $ - input ;equ - определение длина переменной, inputlen - переменная, $ -текущее место в памяти (H - текущее место в паямти) отсюда и длина
    fnum db "Number1: ",  
    fnumlen equ $ - fnum    
    snum db "Number2: ",  
    snumlen equ $ - snum   
    tnum db "Number3: ",  
    tnumlen equ $ - tnum
    output db "Numbers in reverse order: ", 0xA ; Переменная db - date.byte (Под каждый символ байт), 0xA - переход на новую строку
    outputlen equ $ - output ;equ - определение длина переменной, inputlen - переменная, $ -текущее место в памяти (H - текущее место в паямти) отсюда и длина
   
section .bss ; Секция объявления переменных ( 5 - размерность в байтах)
    number1 resb 5
    number2 resb 5
    number3 resb 5

section .text ; Cекция кода 
    global _start ; Объявление global_start указывает ядру, с чего начинается выполнение программы.

_start:
;Вывод в консоль "Input numbers:"
    mov eax, 4          ; 4 - номер системного вызова (sys_write)
    mov ebx, 1          ; 1 - файловый дескриптор (stdout) |  Ко всем потокам ввода-вывода можно получить доступ через так называемые файловые дескрипторы.
    mov ecx, input      ; Переносим переменную input в ecx
    mov edx, inputlen   ; Переносим длину сообщения для вывода в edx
    int 0x80            ; Вызов ядра
;  num1
    
    ; Вывод в консоль "Number1:"
    mov eax, 4          
    mov ebx, 1          
    mov ecx, fnum       
    mov edx, fnumlen    
    int 0x80            
    
    ; Чтение num1
    mov eax, 3          ; 3 - номер системного вызова  (sys_read)
    mov ebx, 2          ; 2 - файловый дескриптор (stdin)
    mov ecx, number1    ; Ссылка на переменную в которую запишем число 
    mov edx, 5          ; 5 - длина сообщения 
    int 0x80            ; Вызов ядра

;  num2
    mov eax, 4          
    mov ebx, 1         
    mov ecx, snum       
    mov edx, snumlen    
    int 0x80            
    
    mov eax, 3          
    mov ebx, 2          
    mov ecx, number2       
    mov edx, 5          
    int 0x80            
    
; num3
    mov eax, 4          
    mov ebx, 1          
    mov ecx, tnum      
    mov edx, tnumlen   
    int 0x80            
    
    mov eax, 3          
    mov ebx, 2          
    mov ecx, number3       
    mov edx, 5          
    int 0x80            

; Вывод "Numbers in reverse order:"
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, outputlen
    int 0x80
   
    ; Вывод num3 
    mov eax, 4
    mov ebx, 1
    mov ecx, number3
    mov edx, 5
    int 0x80

    ; Вывод num2 
    mov eax, 4
    mov ebx, 1
    mov ecx, number2
    mov edx, 5
    int 0x80

    ; Вывод num1 
    mov eax, 4
    mov ebx, 1
    mov ecx, number1
    mov edx, 5
    int 0x80

; Завершение прошграммы
    mov eax, 1
    int 0x80
