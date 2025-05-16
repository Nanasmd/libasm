; int ft_strcmp(const char *s1, const char *s2)
; rdi = s1, rsi = s2

section .text
    global ft_strcmp

ft_strcmp:
    xor rax, rax           ; Clear return register
    xor rcx, rcx           ; Initialize counter to 0

.loop:
    movzx rax, byte [rdi + rcx] ; Load byte from s1 with zero extension
    movzx rdx, byte [rsi + rcx] ; Load byte from s2 with zero extension
    
    cmp rax, 0             ; Check if end of s1
    je .compare            ; If end of s1, compare final bytes
    
    cmp rax, rdx           ; Compare current bytes
    jne .compare           ; If different, calculate difference
    
    inc rcx                ; Increment counter
    jmp .loop              ; Continue loop

.compare:
    sub rax, rdx           ; Calculate difference (s1[i] - s2[i])
    ret                    ; Return difference in rax