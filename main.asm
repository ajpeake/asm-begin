.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

.data
	; define your vaiables here
.code

main PROC
	; write your assemply code here
	nop
	pushfd
	pop ebx
	nop

	INVOKE ExitProcess, 0
main ENDP
END main