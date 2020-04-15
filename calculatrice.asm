SYS_WRITE equ 4
SYS_READ equ 3
SYS_EXIT equ 1
STDIN equ 0
STDOUT equ 1

section .data
msgchoix dw 'Bonjour veulliez choisir le type de calcul en rentrant 1:addition 2:mul'
lenmsgchoix equ $ - msgchoix
msg1add dw 'Bonjour veuillez choisir un nombre a additionner',0xa
lenmsg1add equ $ - msg1add
msg2add dw 'le deuxieme',0xa
lenmsg2add equ $ - msg2add
msg1mul dw 'premier nombre a multiplier',0xa
lenmsg1mul equ $ - msg1mul
msg2mul dw 'deuxieme nombre',0xa
lenmsg2mul equ $ - msg2mul
msg3 dw 'le resultat est : '
lenmsg3 equ $ - msg3
msg4 dw '',0xa

section .bss
choix resb 2
num1 resb 2
num2 resb 2
sum resb 2

section .text
	global _start

_start:
	mov eax,SYS_WRITE
	mov ebx,STDOUT
	mov ecx,msgchoix
	mov edx,lenmsgchoix
	int 0x80
	
	;choix du type de calcul

	mov eax,SYS_READ
	mov ebx,STDIN
	mov ecx,choix
	mov edx,2
	int 0x80
	
	mov ecx,[choix]
	cmp ecx,'1'
	je addition
	jmp multiplication
	
multiplication:
	
	mov eax,SYS_WRITE
	mov ebx,STDOUT
	mov ecx,msg1mul
	mov edx,lenmsg1mul
	int 0x80

	mov eax,SYS_READ
	mov ebx,STDIN
	mov ecx,num1
	mov edx,2
	int 0x80

	mov eax,SYS_WRITE
	mov ebx,STDOUT
	mov ecx,msg2mul
	mov edx,lenmsg2mul
	int 0x80

	mov eax,SYS_READ
	mov ebx,STDIN
	mov ecx,num2
	mov edx,2
	int 0x80

	;calcul

	mov eax,[num1]
	sub eax,'0'

	mov ebx,[num2]
	sub ebx,'0'

	mul ebx
	add eax,'0'
	mov [sum],eax

	jmp resultat

addition :

	mov eax,SYS_WRITE
	mov ebx,STDOUT
	mov ecx,msg1add
	mov edx,lenmsg1add
	int 0x80

	mov eax,SYS_READ
	mov ebx,STDIN
	mov ecx,num1
	mov edx,2
	int 0x80

	mov eax,SYS_WRITE
	mov ebx,STDOUT
	mov ecx,msg2add
	mov edx,lenmsg2add
	int 0x80
	
	mov eax,SYS_READ
	mov ebx,STDIN
	mov ecx,num2
	mov edx,2
	int 0x80

	;calcul

	mov eax,[num1]
	sub eax,'0'

	mov ebx,[num2]
	sub eax,'0'

	add eax,ebx
	add eax,'0'
	mov [sum],eax
	
	jmp resultat

resultat:
	mov eax,SYS_WRITE
	mov ebx,STDOUT
	mov ecx,msg3
	mov ebx,lenmsg3
	int 0x80

	mov eax,SYS_WRITE
	mov ebx,STDOUT
	mov ecx,sum
	mov edx,2
	int 0x80

	mov eax,SYS_WRITE
	mov ebx,STDOUT
	mov ecx,msg4
	mov edx,1
	int 0x80
	
	jmp exit

exit:
	mov eax,SYS_EXIT
	xor ebx,ebx
	int 0x80
















