; Написать программу определения области попадания точки. Необходимо сделать: 
; 1. ввод координат точки с клавиатуры; 
; 2. анализ, в какую область попала точка; 
; 3. вывод на экран сообщения о положении точки.

%macro print 2
    mov ecx, %1             ; Адрес строки
    mov edx, %2             ; Размер строки
    mov eax, 4              ; system call number (sys_write)
    mov ebx, 1              ; file descriptor (stdout)
    int 0x80
%endmacro

%macro read 2
    mov ecx, %1             ; Адрес строки
    mov edx, %2             ; Размер строки
    mov eax, 3              ; system call number (sys_read)
    mov ebx, 2              ; file descriptor (stdin) 
    int 0x80
%endmacro

section .data
    inputX db 0xA, "Введите координату X: "
    inputXlen equ $ - inputX
    inputY db 0xA, "Введите координату Y: "
    inputYlen equ $ - inputY

    str_output db "===OUTPUT===",0xA
    str_output_len equ $ - str_output

    otvet db 0xA, "Точка в зоне: "
    otvetLen equ $ - otvet

    zoneNumber db '1'
    newLine db 0xA

    relativeToLine db 0
    relativeToRectangle db 0
    relativeToCircle db 0



section .bss
    X resb 5
    X2 resb 5
    Y resb 5

section .text
    global _start

_start:
    xor eax, eax
    print inputX, inputXlen
    read X, 5
    mov al, [X]
    sub al, '0'
    mov [X], al

    print inputY, inputYlen
    read Y, 5
    mov al, [Y]
    sub al, '0'
    mov [Y], al

    mov al, [X]
    cmp al, 3 

    print str_output, str_output_len ; Вывол в консоль '===OUTPUT==='
    
    jbe left_to_line ; al <= 3
    ja right_to_line ; al > 3

    left_to_line:
        mov byte [relativeToLine], 0
        jmp compare_to_rectangle

    right_to_line:
        mov byte [relativeToLine], 1
        jmp compare_to_rectangle
    
compare_to_rectangle:
    mov al, [X]
    cmp al, 5
    jb outside_rectangle
    cmp al, 8
    ja outside_rectangle
    mov al, [Y]
    cmp al, 0
    jb outside_rectangle
    cmp al, 5
    ja outside_rectangle

    jmp inside_rectangle

    inside_rectangle:
        mov byte [relativeToRectangle], 2
        jmp compare_to_circle

    outside_rectangle:
        mov byte [relativeToRectangle], 0
        jmp compare_to_circle

compare_to_circle:
    xor eax, eax
    mov al, [X]
    sub al, 4
    mov dl, al
    mul dl
    mov [X2], al

    xor eax, eax
    mov al, [Y]
    sub al, 5
    mov dl, al
    mul dl
    add al, [X2]
    mov [Y], al
    cmp al, 9
    ja outside_circle
    jbe inside_circle

    inside_circle:
        mov byte [relativeToCircle], 4
        jmp zonecheck

    outside_circle:
        mov byte [relativeToCircle], 0
        jmp zonecheck

    zonecheck:
        xor eax, eax
        mov al, [relativeToLine]
        add al, [relativeToRectangle]
        add al, [relativeToCircle]

        cmp al, 7 
        mov byte [zoneNumber], '4'
        je exit ;al = 7            ;jamp если равно (0)
        
        cmp al, 3
        mov byte [zoneNumber], '5'
        je exit ;al = 3

        cmp al, 0
        mov byte [zoneNumber], '1'
        je exit

        cmp al, 4
        mov byte [zoneNumber], '2'
        je exit

        cmp al, 5
        mov byte [zoneNumber], '3'
        je exit

        cmp al, 1
        je proverkadop
        

    proverkadop:
        mov al, [X]
        cmp al, 5
        ja zoneseven ;al>5
        mov byte [zoneNumber], '6'
        jmp exit

    zoneseven:
        mov byte [zoneNumber], '7'
        jmp exit


exit:
    print otvet, otvetLen
    print zoneNumber, 2
    print newLine, 2

    mov eax, 1
    mov ebx, 0
    int 0x80

