%include "../include/io.mac"

extern printf
extern position
global solve_labyrinth

; you can declare any helper variables in .data or .bss

section .data
    deltaX dd -1, 1, 0, 0
    deltaY dd 0, 0, -1, 1

section .bss
    max_rows resd 1
    max_cols resd 1

section .text

; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
solve_labyrinth:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
    mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
    mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
    mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
    mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    
    mov [max_rows], ecx ; save max number of rows
    mov [max_cols], edx ; save max number of cols

    mov dword [eax], 0 ; set x coordinate to 0
    mov dword [ebx], 0 ; set y coordinate to 0
    xor edx, edx
    xor edi, edi

    search_exit:
        set_visited_current_position:
            mov edx, [eax] ; get current x
            mov edi, [ebx] ; get current y

            mov ecx, [esi + edx * 4]
            mov byte [ecx + edi], 0x39 ; set a[x][y] with 1

        xor ecx, ecx

        check_available_moves_loop:
            mov edx, [eax] ; get current x
            mov edi, [ebx] ; get current y

            add edx, [deltaX + ecx * 4] ; add move offset x (new_x)
            add edi, [deltaY + ecx * 4] ; add move offset y (new_y)

            check_out_of_bounds:
                cmp edx, 0
                jl check_available_moves_loop_cond

                cmp edi, 0
                jl check_available_moves_loop_cond

            check_exit:
                cmp edx, [max_rows]
                jge end

                cmp edi, [max_cols]
                jge end

            check_empty_cell:
                push ecx

                mov ecx, [esi + edx * 4]
                mov cl, [ecx + edi]

                cmp cl, 0x30 ; check if a[new_x][new_y] is 0
                jne skip_move

                pop ecx

                mov [eax], edx ; x = new_x
                mov [ebx], edi ; y = new_y

                jmp search_exit
                
            skip_move:
                pop ecx

        check_available_moves_loop_cond:
            inc ecx
            cmp ecx, 4
            jne check_available_moves_loop
    
    jmp search_exit

    ;; Freestyle ends here
end:
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
