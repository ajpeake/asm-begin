;   Executable name : kangaroo
;   Version         : 1.0
;   Created date    : 07/11/2018
;   Last update     : 07/11/2018
;   Author          : Arthur Peake
;   Description     : A simple assembly app for Linux, using NASM 2.13.02,
;                     demostrating how to convert a string from caps to 
;					  lower case.
;
;   Build using these commands:
;      nasm -f elf -g -F stabs eatsyscall.asm
;      ld -o eatsyscall eatsyscall.o
;

SECTION .data			; Section containing initialized data

	Snippet: db "KANGAROO", 10
	SnipLen: equ $-Snippet

SECTION .text			; Section containing code

global _start			; linker needs this to find the entry point!
_start:

		nop					; This no-op keeps gdb happy...
;Put experiments between the two nops...

		mov eax, 4			; Specify sys_write syscall
		mov ebx, 1			; Specify File Descriptor 1: Standard Output
		mov ecx, Snippet	; Pass offset of the message
		mov edx, SnipLen	; Pass the length of the message
		int 80H				; Make syscall to output the text to stdout

		mov ebx, Snippet	; Put address of string in ebx
		mov eax, 8			; number os characters in string
DoMore:	add byte [ebx], 32	; add 32 to value in sting
		inc ebx				; move to the next character in the string
		dec eax				; take loop counter down by one
		jnz DoMore			; Jump to label DoMore if eax is not zero
							;  signifying that the countdown is not over yet

		mov eax, 4			; Specify sys_write syscall
		mov ebx, 1			; Specify File Descriptor 1: Standard Output
		mov ecx, Snippet	; Pass offset of the message
		mov edx, SnipLen	; Pass the length of the message
		int 80H				; Make syscall to output the text to stdout

		mov eax, 1			; Specify Exit syscall
		mov ebx, 0			; Return code of zero
		int 80H				; Make syscall to terminate the program
	
SECTION .bss			; Section containing uninitialized data

