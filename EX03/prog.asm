DEFAULT REL

extern printf
extern scanf

segment .data
      promptGenre   db "Etes-vous un homme (0) ou une femme (1) ? ",0

      msgMonsieur   db "Bonjour Monsieur",0
      msgMadame     db "Bonjour Madame",0
      msg           db "Bonjour",0

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

    lea rdi,[promptGenre]
    call print_string
        lea rdi,[reponse]
        call read_int

    mov rax, [reponse]
    cmp rax, 0
    je afficher_monsieur

    cmp rax, 1
    je afficher_madame

    lea rdi,[msg]
    call print_string

    jmp fin_affichage


afficher_monsieur:
    lea rdi,[msgMonsieur]
    call print_string

afficher_madame:
    lea rdi,[msgMadame]
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
