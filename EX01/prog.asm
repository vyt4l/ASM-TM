DEFAULT REL

extern printf
extern scanf

segment .data 
prompt1       db "Entrez un entier : ",0
prompt2       db "Entrez un autre entier : ",0

label_or      db "OR : ",0
label_and     db "AND : ",0
label_xor     db "XOR : ",0
longIntFormat db "%ld",0
newLine 	    db 10,0

segment .bss  
entier1  resq 1
entier2  resq 1

resultat_or  resq 1
resultat_and resq 1
resultat_xor resq 1

segment .text
        global  main

main:
    push rbp
        mov rbp,rsp
    push rbx
    push r12
    lea rdi,[prompt1]

    call print_string
        lea rdi,[entier1]
        call read_int
        lea rdi,[prompt2]
    
    call print_string
        lea rdi,[entier2]
    
    call   read_int 

    mov rbx,[entier1]  
    mov rcx,[entier2]  

;OR
    mov rax, rbx
    or rax, rcx
    mov [resultat_or], rax

;AND
    mov rax, rbx
    and rax, rcx
    mov [resultat_and], rax

;XOR
    mov rax, rbx
    xor rax, rcx
    mov [resultat_xor], rax 

;render OR
    lea rdi,[label_or]
    call print_string
    mov rdi,[resultat_or]
    call print_int
    lea rdi,[newLine]
    call print_string

; render AND
    lea rdi,[label_and]
    call print_string
    mov rdi,[resultat_and]
    call print_int
    lea rdi,[newLine]
    call print_string

; render XOR
    lea rdi,[label_xor]
    call print_string
    mov rdi,[resultat_xor]
    call print_int
    lea rdi,[newLine]
    call print_string

; reste
    pop r12
    pop rbx
    pop rbp
;exit
    mov rax, 0
    ret

print_string:
    enter 0,0
    mov rax,0
    call printf wrt ..plt
    mov rax,0
    leave
    ret

print_int:
    enter 0,0
    mov rsi,rdi
    lea rdi,[longIntFormat]
    mov rax,0
    call printf wrt ..plt
    mov rax,0
    leave
    ret
    
read_int:
    enter 0,0
    mov rsi,rdi
    lea rdi,[longIntFormat]
    mov rax,0
    call scanf wrt ..plt
    mov rax,0
    leave
    ret

