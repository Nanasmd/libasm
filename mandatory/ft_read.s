; ssize_t ft_read(int fd, void *buf, size_t count)
; rdi = fd, rsi = buf, rdx = count

section .text
    global ft_read
    extern __errno_location

ft_read:
    mov rax, 0             ; syscall number for read
    syscall                ; invoke syscall
    
    cmp rax, 0             ; check if rax < 0 (error)
    jl .error              ; if rax < 0, handle error
    ret                    ; return value is already in rax

.error:
    neg rax                ; get positive error code
    mov r11, rax           ; save error code
    call __errno_location wrt ..plt  ; get address of errno
    mov [rax], r11         ; set errno to error code
    mov rax, -1            ; return -1
    ret