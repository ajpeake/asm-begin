uppercaser: uppercaser.o
	ld -o uppercaser uppercaser.o -melf_i386

uppercaser.o: uppercaser.asm
	nasm -f elf -g -F stabs uppercaser.asm -l uppercaser.lst

clean:
	rm -f uppercaser uppercaser.lst uppercaser.o core

