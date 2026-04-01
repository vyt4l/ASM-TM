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

  mov r12 , 9
  lea rbx , [tableau]

boucle_tri_ext:
  push r13
  push r14
  mov r13 , r12
  lea r14 , [rbx]

boucle_tri_int:
  mov rax , [r14]
  mov rcx , [r14 + 8]
  
  cmp rax , rcx
  jge pas_de_swap
  
  mov [r14] , rcx
  mov [r14 + 8] , rax

pas_de_swap:
  add r14 , 8
  dec r13
  jnz boucle_tri_int

  pop r14
  pop r13
  dec r12
  jnz boucle_tri_ext

  mov r12 , 10
  lea rbx , [tableau]

boucle_affichage:
  mov rdi , [rbx]
  call print_int
  lea rdi , [space]
  call print_string
  
  add rbx , 8
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
