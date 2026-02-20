DEFAULT REL

extern printf
extern scanf

segment .data 
  prompt1       db "Entrez un entier : ",0
  prompt2       db "Entrez un deuxième entier : ",0
  prompt3       db "Entrez un troisième entier : ",0
  formatSortie  db "Produit : ",0
  longIntFormat db "%ld",0
  newLine 	    db 10,0

segment .bss  
  entier1  resq 1
  entier2  resq 1
  entier3  resq 1
  resultat  resq 1

segment .text
  global main

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
  call read_int
  
  lea rdi,[prompt3]
  call print_string
  lea rdi,[entier3]
  call read_int
  
  mov rbx,[entier1]
  mov rcx,[entier2]
  mov rdx, 0
  
  while1:
    cmp rcx, 0
    je endwhile1
    mov r10, rcx
    and r10, 1
    if1:
      cmp r10, 0
      je endif1
      add rdx, rbx
    endif1:
    shl rbx, 1
    shr rcx, 1
    jmp while1
  endwhile1:
  
  mov rbx, rdx
  mov rcx, [entier3]
  mov rdx, 0
  
  while2:
    cmp rcx, 0
    je endwhile2
    mov r10, rcx
    and r10, 1
    if2:
      cmp r10, 0
      je endif2
      add rdx, rbx
    endif2:
    shl rbx, 1
    shr rcx, 1
    jmp while2
  endwhile2:
  
  mov [resultat], rdx
  lea rdi,[formatSortie]
  call print_string
  mov rdi,[resultat]
  call print_int
  
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

