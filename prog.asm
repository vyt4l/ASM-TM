DEFAULT REL
; fonctions externes pour les entrees/sortie
extern printf
extern scanf
; memoire globale donnees initialisees
segment .data 
prompt1       db "Entrez un entier : ",0
prompt2       db "Entrez un autre entier : ",0
formatSortie  db "Somme : ",0
longIntFormat db "%ld",0
newLine 	db 10,0
; memoire globale donnees non initialisees
segment .bss  
entier1  resq 1
entier2  resq 1
resultat resq 1

segment .text ; code du programme
        global  main
main:  ; fonction appelee par le programme C
; sauvegarde des registres sur la pile 
;(obligatoirement un nombre impair)
	push rbp
        mov rbp,rsp
	push rbx
	push r12
; appel print_string
	lea rdi,[prompt1]
	call print_string
; appel read_int
        lea rdi,[entier1]
        call read_int
	mov rbx,[entier1]
; appel print_string
        lea rdi,[prompt2]
	call print_string
; appel read_int
        lea rdi,[entier2]
	call   read_int 
	mov rcx,[entier2]
; calcul de la somme et sauvegarde du resultat en memoire
	add rbx,rcx
	mov [resultat],rbx
; appel print_string
	lea rdi,[formatSortie]
	call print_string
        
    mov rdi,[resultat]
	call print_int
	lea rdi,[newLine]
	call print_string
; restauration des registres
	pop r12
	pop rbx
	pop rbp
; envoi de 0 au systeme d'exploitation
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

