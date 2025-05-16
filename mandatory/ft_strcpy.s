; char *ft_strcpy(char *dst, const char *src)
; rdi = dst, rsi = src

section .text
    global ft_strcpy

ft_strcpy:
    mov rax, rdi           ; Save destination for return value
    xor rcx, rcx           ; Initialize counter to 0

.loop:
    mov dl, byte [rsi + rcx] ; Load byte from source
    mov byte [rdi + rcx], dl ; Store byte to destination
    cmp dl, 0              ; Check if null terminator
    je .done              ; If null terminator, we're done
    inc rcx               ; Increment counter
    jmp .loop             ; Continue loop

.done:
    ret                   ; Return dst in rax