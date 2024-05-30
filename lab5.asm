%macro print 2
    push eax
    push ebx
    push ecx
    mov ecx, %1             ; Адрес строки
    mov edx, %2             ; Размер строки
    mov eax, 4              ; system call number (sys_write)
    mov ebx, 1              ; file descriptor (stdout)
    int 0x80
    pop ecx
    pop ebx
    pop eax
%endmacro

%macro read 2
    push eax
    push ebx
    push ecx
    mov ecx, %1             ; Адрес строки
    mov edx, %2             ; Размер строки
    mov eax, 3              ; system call number (sys_read)
    mov ebx, 2              ; file descriptor (stdin) 
    int 0x80
    pop ecx
    pop ebx
    pop eax
%endmacro

section .data
    ;LAB1
    input db "Input", 
    inputlen equ $ - input
    output db "Output"
    outputlen equ $ - output
    newline db 0xA
    digit db '1'
    ;LAB2
    enterA db "Enter A: ", 0xA
    enterlen equ $ - enterA
    enterB db "Enter B: ", 0xA
    enterC db "Enter C: ", 0xA
    enterD db "Enter D: ", 0xA
    enterE db "Enter E: ", 0xA
    resultStr db "Result: "
    resultStrLen equ $ - resultStr
    ;LAB3
    inputX db 0xA, "Input X: "
    inputXlen equ $ - inputX
    inputY db 0xA, "Input Y: "
    inputYlen equ $ - inputY

    onTheLine db 0xA, "NA LINII"
    onTheLineLen equ $ - onTheLine

    leftToLine db 0xA, "SLEVA OT LINII"
    leftToLineLen equ $ - leftToLine

    rightToLine db 0xA, "SPRAVA OT LINII"
    rightToLineLen equ $ - rightToLine

    insideRectangle db 0xA, "RECTANGLE INSIDE"
    insideRectangleLen equ $ - insideRectangle

    outsideRectangle db 0xA, "RECTANGLE OUTSIDE"
    outsideRectangleLen equ $ - outsideRectangle

    outsideCircle db 0xA, "CIRCLE OUTSIDE", 0xA
    outsideCircleLen equ $ - outsideCircle

    insideCircle db 0xA, "CIRCLE INSIDE", 0xA
    insideCircleLen equ $ - insideCircle
    ;LAB5
    string1 db "Input height: "
    string1len equ $ - string1
    string2 db "Input character: "
    string2len equ $ - string2
    string3 db "Input zero character: "
    string3len equ $ - string3
    symbol1 db " "

section .bss
    ;LAB1
    num1 resb 4
    num2 resb 4
    num3 resb 4
    ;LAB2
    A resb 1
    B resb 1
    C resb 1
    D resb 1
    E resb 1
    sumres resb 3
    mulres resb 3
    divres resb 3
    subres resb 3
    result resb 3
    ;LAB3
    X resb 5
    Y resb 5
    ;LAB5
    symbol resb 2
    height resb 2

section .text
    global _start

_start:

    call lab1

    call lab2

    call lab3

    call lab5

    call exit

lab1:
    print input, inputlen
    print digit, 1
    print newline, 1
    
    read num1, 4
    inc byte [digit]

    print input, inputlen
    print digit, 1
    print newline, 1
    
    read num2, 4
    inc byte [digit]

    print input, inputlen
    print digit, 1
    print newline, 1
    read num3, 4

    print output, outputlen
    print digit, 1
    print newline, 1
    print num3, 4
    dec byte [digit]

    print output, outputlen
    print digit, 1
    print newline, 1
    print num2, 4
    dec byte [digit]
    
    print output, outputlen
    print digit, 1
    print newline, 1
    print num1, 4

    RET

lab2:
     print enterA, enterlen
    read A, 5
    print enterB, enterlen
    read B, 5
    print enterC, enterlen
    read C, 5
    print enterD, enterlen
    read D, 5
    print enterE, enterlen
    read E, 5
    call summing
    call multiplying
    call division
    call subtraction
    
    xor eax, eax
    mov al, [subres]
    add eax, '0'
    mov [result], eax

    print resultStr, resultStrLen
    print result, 3
    print newline, 1
    RET
  
    summing:
        xor eax, eax
        xor ebx, ebx

        mov al, [A]
        sub eax,'0'
        mov bl, [B]
        sub bl, '0'
        add al, bl 
        
        mov [sumres], al
        ret

    multiplying:
        xor eax, eax
        xor ecx, ecx
        mov al, [C]
        sub eax,'0'
        mov cl, [D]
        sub ecx,'0'
        mul ecx
        mov [mulres], eax
        ret
        

    division:
        xor eax, eax
        xor ecx, ecx

        mov ax, [sumres]
        mov cl, [mulres]
        div cl
        mov [divres], ax
        ret

    subtraction:
    xor eax, eax
    xor ebx, ebx

    mov al, [divres]
    mov bl, [E]
    sub bl, '0'
    sub al, bl 
    mov [subres], eax
    ret

lab3:
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
    je on_the_line
    jb left_to_line
    ja right_to_line

    on_the_line:
        print onTheLine, onTheLineLen
        jmp compare_to_rectangle
    
    left_to_line:
        print leftToLine, leftToLineLen
        jmp compare_to_rectangle

    right_to_line:
        print rightToLine, rightToLineLen
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
            print insideRectangle, insideRectangleLen
            jmp compare_to_circle

        outside_rectangle:
            print outsideRectangle, outsideRectangleLen
            jmp compare_to_circle

    compare_to_circle:
    xor eax, eax
    mov al, [X]
    sub al, 4
    mov dl, al
    mul dl
    mov [X], al

    xor eax, eax
    mov al, [Y]
    sub al, 5
    mov dl, al
    mul dl
    add al, [X]
    mov [Y], al
    cmp al, 9
    ja outside_circle
    jbe inside_circle

    inside_circle:
        print insideCircle, insideCircleLen
        ret

    outside_circle:
        print outsideCircle, outsideCircleLen
        ret

lab5:
    print string1, string1len
    read height, 2

    print string2, string2len
    read symbol, 2

    xor eax, eax
    mov al, [height]
    sub al, '0'
    mov [height], al
    
    xor eax, eax
    xor ecx, ecx
    xor ebx, ebx

    outerloop:
        inc al
        mov bl, al
        mov cl, [height]
        sub cl, al

        cmp cl, 0
        je innerloop2

        innerloop1:
            print symbol1, 1
            dec cl
            cmp cl, 1
            jge innerloop1

        innerloop2:
            print symbol, 1
            dec bl
            cmp bl, 0
            jne innerloop2
    
        mov bl, al
        innerloop3:
            print symbol, 1
            dec bl
            cmp bl, 0
            jne innerloop3
    
        print newline, 1
        cmp al, [height]
        jne outerloop
    ret

exit: 
    mov eax, 1       ;sys_exit
    mov ebx, 0       ;return 0
    int 0x80
    ret
