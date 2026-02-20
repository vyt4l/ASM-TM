DEFAULT REL

extern printf
extern scanf

segment .data
      promptInt   db "Entrer un entier signé : ",0
      leven db "pair",0
      lodd db "impair",0
      longIntFormat db "%ld",0
      newLine 	    db 10,0

segment .bss
      reponse resq 1

segment .text
        global  main
main:
    push rbp
    mov rbp,rsp
    push rbx
    push r12

    lea rdi,[promptInt]
    call print_string
    lea rdi,[reponse]
    call read_int

    mov rax, [reponse]
    and rax , 1
    cmp rax, 0
    je pair

    lea rdi,[lodd]
    call print_string

    jmp fin_affichage

pair:
    lea rdi,[leven]
    call print_string

fin_affichage:
    lea rdi,[newLine]
    call print_string

    pop r12
    pop rbx
    pop rbp

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
