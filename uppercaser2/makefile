uppercaser2: uppercaser2.o
	ld -o uppercaser2 uppercaser2.o -melf_i386

uppercaser2.o: uppercaser2.asm
	nasm -f elf -g -F stabs uppercaser2.asm -l uppercaser2.lst

clean:
	rm -f uppercaser2 uppercaser2.lst uppercaser2.o core

