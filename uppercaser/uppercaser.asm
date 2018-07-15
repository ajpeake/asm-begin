;   Executable name : uppercaser
;   Version         : 1.0
;   Created date    : 07/15/2018
;   Last update     : 07/15/2018
;   Author          : Arthur Peake
;   Description     : A simple assembly app for Linux, using NASM 2.13.02,
;                     demostrating how to convert a file from lower case 
;					  to upper case. 
;
;   Build using these commands:
;      nasm -f elf -g -F stabs uppercaser.asm
;      ld -o uppercaser uppercaser.o
;
;	Usage: ./uppercaser > outfile < infile
;
SECTION .bss			; Section containing uninitialized data
		Buff resb 1

SECTION .data			; Section containing initialized data

SECTION .text			; Section containing code

global _start			; linker needs this to find the entry point!
_start:

		nop					; This no-op keeps gdb happy...

Read:	mov eax, 3			; Specify sys_read call
		mov ebx, 0			; Specify File Descriptor 0: Standard Input
		mov ecx, Buff		; Pass address of the buffer to read to
		mov edx, 1			; Tell sys_read to read one char from stdin
		int 80h				; Call sys_read

		cmp eax, 0			; Look at sys_read's return calue in EAX
		je Exit				; Jump if equal to 0 (0 means EOF) to Exit
							; or fall through to test for lowercase

		cmp byte[Buff], 61h	; Test input char against lowercase 'a'
		jb Write			; If below 'a' in ASCII chart, not lowercase
		cmp byte[Buff], 7Ah	; Text input char against lowercase 'z'
		ja Write			; If above 'z' in ASCII chart, not lowercase
							; At this point, we have a lowercase char
		sub byte[Buff], 20h	; Subtract 20h from lowercase char to get uppercase char
							; ...and then write out the char to stdout

Write:	mov eax, 4			; Specify write_sys call
		mov ebx, 1			; Specify File Descriptor 1: Standard output
		mov ecx, Buff		; Pass address of the character to write
		mov edx, 1			; Pass number of chars to write
		int 80h				; Call sys_write
		jmp Read			; ...then go to the beginning to get another character

Exit:	mov eax, 1			; Specify Exit syscall
		mov ebx, 0			; Return code of zero
		int 80H				; Make syscall to terminate the program
