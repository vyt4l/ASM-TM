DEFAULT REL

extern printf
extern scanf

segment .data 
  prompt       db "Entrer un entier signé : ",0
  formatSortie  db "Le nombre de 1 dans sa representation binaire : ",0
  longIntFormat db "%ld",0
  newLine 	    db 10,0

segment .bss  
  entier  resq 1
  resultat  resq 1

segment .text
  global main

main:
  push rbp
  mov rbp,rsp
  push rbx
  push r12

  lea rdi,[prompt]
  call print_string
  lea rdi,[entier]
  call read_int
  
  mov rax , [entier] 
  lea rbx , resultat
  mov rbx , 0

  while1 :
    cmp rax , 0
    je endwhile1

    mov r8 , rax
    and r8 , 1
    
    cmp r8 , 1
    je if1

    jmp endif1
    
    if1 :
      add rbx , 1
    endif1 :
    
    shr rax , 1
    
    jmp while1
  endwhile1 :

  lea rdi , [formatSortie]
  call print_string

  mov rdi , rbx
  call print_int

  lea rdi , [newLine]
  call print_string

  jmp fin_affichage

fin_affichage:
    pop r12
    pop rbx
    pop rbp

    mov     rax, 0
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

