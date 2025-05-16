; int ft_atoi_base(char *str, char *base)
; rdi = str, rsi = base

section .text
    global ft_atoi_base
    extern ft_strlen

ft_atoi_base:
    push rbp
    mov rbp, rsp
    push rbx                ; callee-saved registers
    push r12
    push r13
    push r14
    push r15

    ; Check if str or base is NULL
    test rdi, rdi
    jz .error
    test rsi, rsi
    jz .error

    ; Save parameters
    mov r12, rdi           ; str
    mov r13, rsi           ; base

    ; Get base length
    mov rdi, rsi
    call ft_strlen
    cmp rax, 2
    jl .error              ; Error if base length < 2
    mov r14, rax           ; base_len = strlen(base)

    ; Check base validity
    xor rcx, rcx           ; i = 0
.check_base_loop:
    cmp rcx, r14
    jge .check_base_done

    ; Check for invalid chars in base
    movzx rax, byte [r13 + rcx]
    cmp rax, '+'
    je .error
    cmp rax, '-'
    je .error
    cmp rax, ' '
    je .error
    cmp rax, 9             ; Tab
    je .error
    cmp rax, 10            ; Newline
    je .error
    cmp rax, 13            ; Carriage return
    je .error
    cmp rax, 12            ; Form feed
    je .error
    cmp rax, 11            ; Vertical tab
    je .error

    ; Check for duplicates
    mov rbx, rcx
    inc rbx                ; j = i + 1
.check_dup_loop:
    cmp rbx, r14
    jge .check_dup_done
    cmp al, byte [r13 + rbx]
    je .error              ; Error if duplicate found
    inc rbx
    jmp .check_dup_loop
.check_dup_done:

    inc rcx
    jmp .check_base_loop
.check_base_done:

    ; Skip whitespace
    mov rbx, r12           ; Current position in str
.skip_spaces:
    movzx rax, byte [rbx]
    cmp al, ' '
    je .next_space
    cmp al, 9              ; Tab
    je .next_space
    cmp al, 10             ; Newline
    je .next_space
    cmp al, 13             ; Carriage return
    je .next_space
    cmp al, 12             ; Form feed
    je .next_space
    cmp al, 11             ; Vertical tab
    je .next_space
    jmp .spaces_done
.next_space:
    inc rbx
    jmp .skip_spaces
.spaces_done:

    ; Handle sign
    mov r15, 1             ; sign = 1
.handle_sign:
    movzx rax, byte [rbx]
    cmp al, '+'
    je .next_sign
    cmp al, '-'
    jne .sign_done
    neg r15                ; sign = -sign
.next_sign:
    inc rbx
    jmp .handle_sign
.sign_done:

    ; Convert string
    xor r8, r8             ; result = 0
.convert_loop:
    movzx r9, byte [rbx]   ; Current char
    test r9, r9
    jz .done               ; End if null terminator

    ; Find char in base
    xor rcx, rcx           ; i = 0
.find_char:
    cmp rcx, r14
    je .done               ; Char not found, end conversion
    cmp r9b, byte [r13 + rcx]
    je .char_found
    inc rcx
    jmp .find_char
.char_found:

    ; result = result * base_len + value
    imul r8, r14
    add r8, rcx
    inc rbx                ; Next character
    jmp .convert_loop

.done:
    mov rax, r8
    imul rax, r15          ; Apply sign
    jmp .return

.error:
    xor rax, rax           ; Return 0 on error

.return:
    pop r15                ; Restore callee-saved registers
    pop r14
    pop r13
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret