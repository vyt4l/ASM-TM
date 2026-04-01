DEFAULT REL

extern printf
extern scanf

segment .data 
  prompt         db "Entrer un entier signé : ",0
  space          db " ",0
  longIntFormat  db "%ld",0
  newLine        db 10,0

segment .bss  
  entier  resq 1
  tableau resq 10

segment .text
  global main

main:
  push rbp
  mov rbp,rsp
  push rbx
  push r12

  mov r12 , 10
  lea rbx , [tableau]

boucle_lecture:
  lea rdi,[prompt]
  call print_string
  lea rdi,[entier]
  call read_int
  
  mov rax , [entier]
  mov [rbx] , rax
  
  add rbx , 8
  dec r12
  jnz boucle_lecture
  
  mov r12 , 10
  lea rbx , [tableau + 72]

boucle_affichage:
  mov rdi , [rbx]
  call print_int
  lea rdi , [space]
  call print_string
  
  sub rbx , 8
  dec r12
  jnz boucle_affichage

  jmp fin_affichage

fin_affichage:
  pop r12
  pop rbx
  pop rbp

  mov rax , 0
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
