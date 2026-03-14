DEFAULT REL

extern printf
extern scanf

segment .data 
  prompt       db "Entrer un entier non signe : ",0
  msg_oui      db "OUI 0^k1^n0^n", 0
  msg_non      db "NON pas 0^k1^n0^n", 0
  longIntFormat db "%ld",0
  newLine      db 10,0

segment .bss  
  entier  resq 1

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
  mov r12 , 0
  
  comp0:
    cmp rax , 0
    je oui

    mov rbx , rax
    and rbx , 1
    cmp rbx , 1
    je comp1
 
    inc r12
    shr rax , 1
    jmp comp0

  comp1 :
    mov rbx , rax
    and rbx , 1
    cmp rbx , 1
    je if1

    cmp r12 , 0
    jne non
    jmp comp02
    
    if1 : 
      dec r12
      shr rax , 1
      jmp comp1

  comp02:
    cmp rax , 0
    je oui
    

  jmp fin_affichage

fin_affichage:
  pop r12
  pop rbx
  pop rbp

  mov rax , 0
  ret

non :
  lea rdi , [msg_non]
  call print_string  
  lea rdi , [newLine]
  call print_string
  jmp fin_affichage

oui :
  lea rdi , [msg_oui]
  call print_string  
  lea rdi , [newLine]
  call print_string
  jmp fin_affichage

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
