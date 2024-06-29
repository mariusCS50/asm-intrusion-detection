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

section .text
    global check_passkeys
    extern printf

check_passkeys:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; requests
    mov ecx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ;
    ;; DO NOT MODIFY

    ;; Your code starts here

    check_passkey:
        push ecx ; save the number of iterations

        copy_current_request:
            lea esi, [ebx]
            lea edi, [current_request]
            mov ecx, request_size
            rep movsb ; copy from the current address of the request array
                      ; to curren_request

        check_first_last_bits:
            mov dx, [current_request + login_creds + passkey]
            and dx, 0x8001 ; mask the first and last bits in the 16 bit passkey
            cmp dx, 0x8001 ; check if both bytes are set
            jne not_hacker

        check_lower_higher_bits:
            mov dx, [current_request + login_creds + passkey]
            xor cx, cx

            count_bits_loop:
                push dx ; save the passkey
                
                and dl, 1 ; mask the last byte in the lower half
                and dh, 1 ; mask the last byte in the higher half

                add cl, dl ; add the last byte of lower half to lower counter
                add ch, dh ; add the last byte of lower half to higher counter

                pop dx ; pop back the passkey
                
            count_bits_loop_cond:
                shr dx, 1
                test dh, dh
                jnz count_bits_loop

            test cl, 1 ; check if lower half has odd number of bits
            jz not_hacker

            test ch, 1 ; check if higher half has even number of bits
            jnz not_hacker

        hacker:
            mov byte [eax], 1
            jmp next_indices
        
        not_hacker:
            mov byte [eax], 0

        next_indices: 
            add ebx, request_size ; move to the adress of the next request
            inc eax ; move to the respective address in connected[]

    check_next_passkey:
        pop ecx ; pop back the number of iterations
        dec ecx
        jnz check_passkey

    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY