; size_t ft_strlen(const char *s)
; rdi = s

section .text
    global ft_strlen

ft_strlen:
    xor rax, rax            ; Initialize counter to 0 (rax will hold return value)

.loop:
    cmp byte [rdi + rax], 0 ; Check if current byte is null terminator
    je .done                ; If null terminator found, jump to done
    inc rax                 ; Increment counter
    jmp .loop               ; Continue loop

.done:
    ret                     ; Return length in rax