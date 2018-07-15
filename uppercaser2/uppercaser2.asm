;   Executable name : uppercaser2
;   Version         : 1.0
;   Created date    : 07/15/2018
;   Last update     : 07/15/2018
;   Author          : Arthur Peake
;   Description     : A simple assembly app for Linux, using NASM 2.13.02,
;                     demostrating how to convert a file from lower case 
;					  to upper case using a buffer. 
;
;   Build using these commands:
;      nasm -f elf -g -F stabs uppercaser2.asm
;      ld -o uppercaser2 uppercaser2.o
;
;	Usage: ./uppercaser2 > outfile < infile
;
SECTION .bss					; Section containing uninitialized data
		BUFFLEN	equ 1024		; Length of buffer
		Buff:	resb BUFFLEN	; Text buffer itself

SECTION .data			; Section containing initialized data

SECTION .text			; Section containing code

global _start			; linker needs this to find the entry point!
_start:

		nop					; This no-op keeps gdb happy...

; Read a buffer full of text from stdin

Read:	mov eax, 3			; Specify sys_read call
		mov ebx, 0			; Specify File Descriptor 0: Standard Input
		mov ecx, Buff		; Pass offset of the buffer to read to
		mov edx, BUFFLEN	; Pass number of bytes to read at one pass
		int 80h				; Call sys_read to fill the buffer
		mov esi, eax		; Copy sys_read return value for safekeeping
		cmp eax, 0			; If eax = 0, sys_read reached EOF on stdin
		je Done				; Jump if equal (to 0, fron compare)

; Setup the registers for the process buffer step:
		mov ecx, esi		; Place the number of bytes read into ecx
		mov ebp, Buff		; Place address of buffer into ebp
		dec ebp				; Adjust count to offset

; Go through the buffer and convert lowercase to uppercase characters:

Scan:	cmp byte[ebp+ecx], 61h	; Test input char against lowercase 'a'
		jb Next					; If below 'a' in ASCII chart, not lowercase
		cmp byte[ebp+ecx], 7Ah	; Text input char against lowercase 'z'
		ja Next					; If above 'z' in ASCII chart, not lowercase
								; At this point, we have a lowercase char
		sub byte[ebp+ecx], 20h	; Subtract 20h from lowercase char to get uppercase char
Next:	dec ecx					; Decrement counter
		jnz Scan				; If characters remain, loop back

; Write the buffer full of processed test to stdout:
Write:	mov eax, 4			; Specify write_sys call
		mov ebx, 1			; Specify File Descriptor 1: Standard output
		mov ecx, Buff		; Pass offset of the buffer
		mov edx, esi		; Pass the number of bytes of data in the buffer
		int 80h				; Make sys_write kernel call
		jmp Read			; Loop back and load another buffer full

; All done.

Done:	mov eax, 1			; Specify Exit syscall
		mov ebx, 0			; Return code of zero
		int 80H				; Make syscall to terminate the program
