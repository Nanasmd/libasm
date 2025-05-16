; char *ft_strdup(const char *s)
; rdi = s

section .text
    global ft_strdup
    extern malloc
    extern ft_strlen
    extern ft_strcpy
    extern __errno_location

ft_strdup:
    push rdi                ; save s
    
    ; get length of s
    call ft_strlen          ; length in rax
    
    ; allocate memory
    add rax, 1              ; add 1 for null terminator
    mov rdi, rax            ; size to allocate
    call malloc wrt ..plt   ; allocate memory
    
    ; check if malloc failed
    test rax, rax
    jz .error
    
    ; copy string
    mov rdi, rax            ; destination = allocated memory
    pop rsi                 ; source = original string
    call ft_strcpy          ; copy string
    
    ret                     ; return allocated and filled memory

.error:
    pop rdi                 ; restore stack
    call __errno_location wrt ..plt
    mov dword [rax], 12     ; ENOMEM (out of memory)
    xor rax, rax            ; return NULL
    ret