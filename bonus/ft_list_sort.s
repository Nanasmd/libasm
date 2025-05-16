; void ft_list_sort(t_list **begin_list, int (*cmp)(void *, void *))
; rdi = begin_list, rsi = cmp

section .text
    global ft_list_sort

ft_list_sort:
    push rbp
    mov rbp, rsp
    push rbx               ; Save callee-saved registers
    push r12
    push r13
    push r14
    push r15

    ; Check if begin_list or *begin_list is NULL
    test rdi, rdi
    jz .return
    mov rax, [rdi]
    test rax, rax
    jz .return
    
    ; Check if list has only one element
    mov rbx, [rax + 8]     ; rbx = (*begin_list)->next
    test rbx, rbx
    jz .return             ; If next is NULL, list has only one element
    
    ; Save parameters
    mov r12, rdi           ; begin_list
    mov r13, rsi           ; cmp function
    
    ; Bubble sort
.sort_loop:
    mov rax, [r12]         ; current = *begin_list
    xor r14, r14           ; sorted = false (0)
    
.compare_loop:
    mov rbx, [rax + 8]     ; next = current->next
    test rbx, rbx
    jz .check_sorted       ; If next is NULL, end of list reached
    
    ; Compare current->data and next->data
    push rax
    push rbx
    mov rdi, [rax]         ; current->data
    mov rsi, [rbx]         ; next->data
    call r13               ; cmp(current->data, next->data)
    pop rbx
    pop rax
    
    ; If current->data > next->data, swap them
    test eax, eax
    jle .next_pair         ; If current->data <= next->data, no swap needed
    
    ; Swap data
    mov r15, [rax]         ; temp = current->data
    mov rdx, [rbx]         ; next->data
    mov [rax], rdx         ; current->data = next->data
    mov [rbx], r15         ; next->data = temp
    
    mov r14, 1             ; sorted = true (1)
    
.next_pair:
    mov rax, rbx           ; current = next
    jmp .compare_loop
    
.check_sorted:
    test r14, r14          ; If sorted is true, repeat
    jnz .sort_loop
    
.return:
    pop r15                ; Restore callee-saved registers
    pop r14
    pop r13
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret