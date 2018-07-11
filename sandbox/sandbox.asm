SECTION .data			; Section containing initialized data

SECTION .text			; Section containing code

global _start			; linker needs this to find the entry point!

_start:
		
	nop					; This no-op keeps gdb happy...
;Put experiments between the two nops...

	mov ax, 067FEh
	mov bx, ax
	mov cl, bh
	mov ch, bl
	xchg cl, ch

;Put experiments between the two nops...
	nop					; Put test code before this line...

SECTION .bss			; Section containing uninitialized data

