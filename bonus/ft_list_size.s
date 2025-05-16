; int ft_list_size(t_list *begin_list)
; rdi = begin_list

section .text
    global ft_list_size

ft_list_size:
    xor rax, rax           ; size = 0
    test rdi, rdi          ; Check if list is NULL
    jz .done

.loop:
    inc rax                ; size++
    mov rdi, [rdi + 8]     ; lst = lst->next
    test rdi, rdi          ; Check if next is NULL
    jnz .loop

.done:
    ret