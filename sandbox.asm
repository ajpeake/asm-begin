;	Executable name	: sandbox
;	Version			: 1.1
;	Created date	: 11/03/2015
;	Last update		: 07/04/2018
;	Author			: Arthur Peake
;	Description		: A simple program in assembly for Linux, using NASM 2.11.08,
;		used as a sandbox to test assembly code snippets.
;
;	Build using these commands:
;		nasm -f elf -g -F stabs sandbox.asm
;		ld -o sandbox sandbox.o
;

SECTION .data					; Section containing initialized data


SECTION .text					; Section containing code

global _start					; linker needs this to find the entry point!

_start:
		
		nop						; This no-op keeps gdb happy...
;Put experiments between the two nops...

		mov ax, -42
		movsx ebx, ax

;Put experiments between the two nops...
		nop						; Put test code before this line...

;		mov eax, 1				; Code for Exit Syscall
;		mov ebx, 0				; return code of zero
;		int 80h					; make kernel call

SECTION .bss					; Section containing uninitialized data

