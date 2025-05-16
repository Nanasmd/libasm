; void ft_list_push_front(t_list **begin_list, void *data)
; rdi = begin_list, rsi = data

section .text
    global ft_list_push_front
    extern malloc

ft_list_push_front:
    push rbp
    mov rbp, rsp
    push rdi               ; Save begin_list
    push rsi               ; Save data

    ; Allocate memory for new node
    mov rdi, 16            ; sizeof(t_list) = 16 bytes (8 for data + 8 for next)
    call malloc wrt ..plt
    test rax, rax          ; Check if malloc failed
    jz .error

    ; Set up new node
    pop rsi                ; Restore data
    mov [rax], rsi         ; new->data = data
    pop rdi                ; Restore begin_list
    
    mov rcx, [rdi]         ; rcx = *begin_list
    mov [rax + 8], rcx     ; new->next = *begin_list
    mov [rdi], rax         ; *begin_list = new

    mov rsp, rbp
    pop rbp
    ret

.error:
    pop rsi                ; Clean stack
    pop rdi
    mov rsp, rbp
    pop rbp
    ret