section .data
    input db "The truth is somewhere out there maybe", 0
    key equ 3                ; ключ шифрования

section .bss
    encrypted resb 128        ; зарезервировать место для зашифрованной строки

section .text
    global _start

_start:
    mov ecx, input           ; загрузить адрес входной строки в ecx
    mov edx, 0               ; инициализировать индексную переменную значением 0
    mov esi, encrypted       ; загрузить адрес зашифрованной строки в esi

encrypt_loop:
    mov al, [ecx + edx]      ; загрузить текущий персонаж в al
    cmp al, 0                ; проверяем, достигли ли мы конца строки
    je end_encryption        ; если да, перейдите к метке end_encryption
    add al, key              ; добавить ключ шифрования к персонажу
    cmp al, 'z'              ; проверьте, обернулся ли персонаж до «а»
    jbe store_char           ; если нет, перейдите к store_char
    sub al, 26               ; перейти к началу алфавита

store_char:
    mov [esi + edx], al      ; сохранить зашифрованный символ в зашифрованной строке
    inc edx                  ; увеличить индексную переменную
    jmp encrypt_loop         ; вернуться к началу цикла

end_encryption:
    mov eax, 4               ; номер системного вызова для sys_write
    mov ebx, 1               ; файловый дескриптор для стандартного вывода
    mov ecx, encrypted       ; адрес зашифрованной строки
    mov edx, edx             ; длина зашифрованной строки
    int 0x80                 ; вызвать ядро

    mov eax, 1               ; номер системного вызова для sys_exit
    xor ebx, ebx             ; код выхода 0
    int 0x80                 ; вызвать ядро