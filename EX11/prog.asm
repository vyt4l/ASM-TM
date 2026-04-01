DEFAULT REL

extern printf
extern scanf

segment .data 
  prompt         db "Entrer une chaine de caractères : ",0
  msg_result     db "La chaine transformée : ", 0
  longIntFormat  db "%ld",0
  stringFormat   db "%30s",0
  newLine        db 10,0

segment .bss  
  mot  resb 31

segment .text
  global main

main:
  push rbp
  mov rbp,rsp
  push rbx
  push r12

  lea rdi,[prompt]
  call print_string
  lea rdi,[mot]
  call read_string

  lea rbx , [mot]

boucle_conversion:
  mov al , [rbx]
  cmp al , 0
  je fin_conversion

  cmp al , 'a'
  jl pas_majuscule
  cmp al , 'z'
  jg pas_majuscule

  sub al , 32
  mov [rbx] , al

pas_majuscule:
  inc rbx
  jmp boucle_conversion

fin_conversion:

  lea rdi , [msg_result]
  call print_string  
  lea rdi , [mot]
  call print_string
  lea rdi , [newLine]
  call print_string

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

read_string:
  enter 0,0
  mov rsi,rdi
  lea rdi,[stringFormat]
  mov rax,0
  call scanf wrt ..plt
  mov rax,0
  leave
  ret
