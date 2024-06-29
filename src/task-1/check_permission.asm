%include "../include/io.mac"

extern ant_permissions

extern printf
global check_permission

section .text

check_permission:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; id and permission
    mov     ebx, [ebp + 12] ; address to return the result
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    mov edx, eax
    shr edx, 24 ; get the ant id
    mov edx, [ant_permissions + edx * 4] ; ant_permissions[id]
    
    check_available_rooms:
        and eax, 0x00FFFFFF ; clear the id from the rooms
        and edx, eax 
        cmp eax, edx 
        sete al

    mov [ebx], al
    
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
