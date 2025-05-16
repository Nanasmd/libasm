; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void *, void *), void (*free_fct)(void *))
; rdi = begin_list, rsi = data_ref, rdx = cmp, rcx = free_fct

section .text
    global ft_list_remove_if
    extern free

ft_list_remove_if:
    push rbp
    mov rbp, rsp
    push rbx               ; Save callee-saved registers
    push r12
    push r13
    push r14
    push r15

    ; Check if begin_list is NULL
    test rdi, rdi
    jz .return
    
    ; Save parameters
    mov r12, rdi           ; begin_list
    mov r13, rsi           ; data_ref
    mov r14, rdx           ; cmp function
    mov r15, rcx           ; free_fct
    
.remove_loop:
    mov rax, [r12]         ; current = *begin_list
    test rax, rax
    jz .return             ; If current is NULL, we're done
    
    ; Compare current->data with data_ref
    push rax
    mov rdi, [rax]         ; current->data
    mov rsi, r13           ; data_ref
    call r14               ; cmp(current->data, data_ref)
    pop rax
    
    ; If they are equal, remove the node
    test eax, eax
    jnz .next_node         ; If not equal, go to next node
    
    ; Remove node
    mov rbx, [rax + 8]     ; next = current->next
    
    ; Free data if free_fct is provided
    test r15, r15
    jz .skip_free_data
    
    push rbx
    mov rdi, [rax]         ; current->data
    call r15               ; free_fct(current->data)
    pop rbx
    
.skip_free_data:
    ; Free current node
    push rbx
    mov rdi, rax
    call free wrt ..plt    ; free(current)
    pop rbx
    
    ; Update *begin_list to point to next
    mov [r12], rbx         ; *begin_list = next
    jmp .remove_loop       ; Continue with new current
    
.next_node:
    ; Move to next node by updating begin_list to point to current->next
    lea r12, [rax + 8]     ; begin_list = &(current->next)
    jmp .remove_loop
    
.return:
    pop r15                ; Restore callee-saved registers
    pop r14
    pop r13
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret