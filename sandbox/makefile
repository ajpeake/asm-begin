sandbox: sandbox.o
	ld -o sandbox sandbox.o -melf_i386

sandbox.o: sandbox.asm
	nasm -f elf -g -F stabs sandbox.asm -l sandbox.lst

clean:
	rm -f sandbox sandbox.lst sandbox.o core

