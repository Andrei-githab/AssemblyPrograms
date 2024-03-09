; A и B
; (A/B)*2+3-1 = result
; (2/1)*2+3-1 = 2

%macro print 2
    mov eax, 4          ; 4 - номер системного вызова (sys_write)
    mov ebx, 1          ; 1 - файловый дескриптор (stdout) |  Ко всем потокам ввода-вывода можно получить доступ через так называемые файловые дескрипторы.
    mov ecx, %1         ; Переносим переменную 1 в ecx
    mov edx, %2         ; Переносим длину сообщения для вывода в edx (2 переменная)
    int 0x80            ; Вызов ядра
%endmacro

%macro input 1
    mov eax, 3          ; 3 - номер системного вызова r (sys_read)
    mov ebx, 2          ; 2 - файловый дескриптор (stdin)
    mov ecx, %1         ; Ссылка на переменную в которую запишем число 
    mov edx, 5          ; 5 - длина сообщения 
    int 0x80            ; Вызов ядра (Прерывание)
%endmacro

%macro asciitod 2 
    mov eax, [A]                      
    sub eax, 2560d + '0' 
    mov cl, [B]
    sub ecx, 2560d + '0'
    mov [A],eax
    mov [B],ecx
%endmacro

%macro printres 1
    xor eax, eax  ; Обнуляем eax
    mov al, [%1]
    add eax, 2560d + '0'
    mov [result], eax
    print result, 5
%endmacro


section .data 
    mth db "(A/B)*2+3-1 = result",0xA ; Переменная db - date.byte (Под каждый символ байт), 0xA - переход на новую строку (/n)
    mthlen equ $ - mth                ;equ - определение длина переменной, inputlen - переменная, $ -текущее место в памяти (H - текущее место в паямти) отсюда и длина
    strinput db "input number (0..9):"
    strinputlen equ $ - strinput
    stroutput db "===OUTPUT===",
    stroutputlen equ $ - stroutput
    stroutputsum db  0xA,"Sum: "
    stroutputsumlen equ $ - stroutputsum
    stroutputmulres db  0xA,"Mul: "
    stroutputmulreslen equ $ - stroutputmulres
    stroutputdivres db  0xA,"Div: "
    stroutputdivreslen equ $ - stroutputdivres
    stroutputsubres db  0xA,"Sub: "
    sstroutputsubreslen equ $ - stroutputsubres
    stroutputresult db  0xA,"RESULT: "
    stroutputresultlen equ $ - stroutputresult


section .bss ; Секция объявления переменных ( 5 - размерность в байтах)
    A resb 5
    B resb 5
    sum resb 5
    mulres resb 5
    divres resb 5
    subres resb 5
    result resb 5


section .text
    global _start

_start:
    print mth, mthlen
    print strinput, strinputlen ; Вывол в консоль 'input number (0..9)'
    input A  ; Ввод с клавиатуры A

    print strinput, strinputlen ; Вывол в консоль 'input number (0..9)'
    input B  ;Ввод с клавиатуры A
    
    print stroutput, stroutputlen ; Вывол в консоль '===OUTPUT==='

    asciitod A,B        ; Перевод из ascii в чсило 
                        ; (A/B)*2+1-1 = result
    call division       ; деление 
    call multiply       ; умножение
    call summ           ; сумма
    call subtraction    ; вычитание

    call printresult    ; результат
    
    call exit           ; Завершение программы 

multiply:
    call regtozero ; Обнуляем регистры 

    mov al, [divres]
    mov cl, 2
    mul cl             ;al * cl = ax
    mov [mulres], ax

    print stroutputmulres, stroutputmulreslen
    printres mulres 
ret

subtraction:
    call regtozero ; Обнуляем регистры 

    mov al, [sum]
    mov bl, 1
    sub al, bl       ;al - cl = eax
    mov [subres], eax
    
    print stroutputsubres, sstroutputsubreslen ; Вывод в терминал 
    printres subres ; Вывод в терминал число
ret  

division:
    call regtozero ; Обнуляем регистры 

    mov ax, [A]
    mov cl, [B]
    div cl        ; ax / cl = ax , остаток в  dx 
    mov [divres], ax
    
    print stroutputdivres, stroutputdivreslen ; Вывод в терминал 
    printres divres ; Вывод в терминал число
ret

summ:
    call regtozero ; Обнуляем регистры 

    mov al, [mulres]
    mov bl, 3
    add al, bl  ; al+bl = al
    mov [sum], al
    
    print stroutputsum, stroutputsumlen ; Вывод в терминал 
    printres sum ; Вывод в терминал число
ret

printresult:
    print stroutputresult, stroutputresultlen  ; Вывод в терминал 
    call regtozero ; Обнуляем регистры 

    mov al, [sum]
    add eax, 2560d + '0'
    mov [result], eax

    print result, 5 ; Вывод в терминал число
ret

regtozero:
    ; Функция обнуления регистров
    xor eax, eax
    xor ecx, ecx
    xor ebx, ebx
ret

exit:
    ; Завершение программы
    mov eax, 1
    int 0x80