%include "../include/io.mac"

; declare your structs here

struc creds
    passkey: resw 1
    username: resb 51
endstruc

struc request
    admin: resb 1
    prio: resb 1
    login_creds: resb creds_size
endstruc 
    
section .data
    current_request:
        istruc request
            at admin, db 0
            at prio, db 0
            at login_creds, times 51 db 0
        iend

    next_request:
        istruc request
            at admin, db 0
            at prio, db 0
            at login_creds, times 51 db 0
        iend

section .text
    global sort_requests
    extern printf

sort_requests:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; requests
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

    dec ecx ; bubble sort loops n - 1 times

    outer_loop: ; bubble sort
        push ebx ; save request array adress
        push ecx ; save number of iterations

        mov eax, ecx 

        inner_loop: 
            get_current_request:
                lea esi, [ebx]
                lea edi, [current_request]
                mov ecx, request_size
                rep movsb ; copy from the current address of the request array
                          ; to curren_request

            get_next_request:
                lea esi, [ebx + request_size]
                lea edi, [next_request]
                mov ecx, request_size
                rep movsb ; copy from the next address of the request array
                          ; to next_request

            check_admin:
                mov dl, [current_request + admin]
                cmp dl, [next_request + admin] ; cmp the admin of c_r and n_r
                jb swap_requests
                ja sorted
            
            check_priority:
                mov dl, [current_request + prio]
                cmp dl, [next_request + prio] ; cmp the priority of c_r and n_r
                ja swap_requests
                jb sorted

            check_username:
                ; save the usernames or current_request and next_request in esi
                ; and edi to compare them using string operations
                lea esi, [current_request + login_creds + username]
                lea edi, [next_request + login_creds + username]
                mov ecx, 50
                
                check_alphabetical_order:
                    cmpsb ; compare [esi] with [edi] and then increment both
                    ja swap_requests
                    jb sorted
                loop check_alphabetical_order
                
            swap_requests:
                lea esi, [next_request]
                lea edi, [ebx]
                mov ecx, request_size
                rep movsb ; copy next request to current request's address

                lea esi, [current_request]
                lea edi, [ebx + request_size]
                mov ecx, request_size
                rep movsb ; copy current request to next request's address

            sorted:
                add ebx, request_size ; move to the adress of the next request

        inner_loop_cond:
            dec eax
            jnz inner_loop

        pop ecx ; get back the number of iterations 
        pop ebx ; get back the request array adress

    outer_loop_cond:
        dec ecx
        jnz outer_loop

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY