DEFAULT REL

extern printf
extern scanf

segment .data 
  prompt       db "Entrer un entier signé : ",0
  formatSortie1  db "L'entier EST une puissance de 2",0
  formatSortie2  db "L'entier N'EST PAS une puissance de 2",0
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

  cmp rax, 0
  je false
  
  cmp rax, 0
  jle negat

  jmp check

check :
  mov rbx, rax
  sub rbx , 1

  and rax , rbx
  cmp rax, 0
  je true

  jmp false

negat :
  neg rax
  jmp check 

false :
  lea rdi , [formatSortie2]
  call print_string
  
  lea rdi,[newLine]
  call print_string

  jmp fin_affichage


true :
  lea rdi , [formatSortie1]
  call print_string
  
  lea rdi,[newLine]
  call print_string


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

