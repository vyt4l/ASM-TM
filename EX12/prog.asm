DEFAULT REL

extern printf
extern scanf

segment .data 
  prompt         db "Entrer un entier signé : ",0
  msg_hex        db "hexadecimal : ", 0
  longIntFormat  db "%ld",0
  newLine        db 10,0

segment .bss  
  nombre  resq 1
  buffer  resb 2

segment .text
  global main

main:
  push rbp
  mov rbp,rsp
  push rbx
  push r12

  lea rdi,[prompt]
  call print_string
  lea rdi,[nombre]
  call read_int

  push r13
  push r14
  push r15

  mov rax , [nombre]

  mov r15 , 16

boucle_extraction:
  mov r14 , rax
  and r14 , 0xF
  cmp r14 , 9
  jle est_chiffre
  add r14 , 'a' - 10
  jmp stocker
est_chiffre:
  add r14 , '0'
stocker:
  push r14
  shr rax , 4
  dec r15
  jnz boucle_extraction

  mov r13 , 16

  lea rdi , [msg_hex]
  call print_string

boucle_affichage:
  pop rax
  mov [buffer] , al
  mov byte [buffer+1] , 0
  lea rdi , [buffer]
  call print_string
  
  dec r13
  jnz boucle_affichage

  lea rdi , [newLine]
  call print_string

  pop r15
  pop r14
  pop r13

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
