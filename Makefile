#-----------------##
## Alexander Mayer ##
## Daniel Schlager ##
##      3.2016     ##
##-----------------##

all: clean clang 

.PHONY: clean
clean:
	rm -rf *.mips32 selfie

clang:
	clang -w -m32 -D'main(a, b)=main(int argc, char **argv)' selfie.c -o selfie

debug:
	clang -w -m32 -D'main(a, b)=main(int argc, char **argv)' selfie.c -o selfie -g && gdb selfie

selftest: 
	clang -w -m32 -D'main(a, b)=main(int argc, char **argv)' selfie.c -o selfie -g && ./selfie -c selfie.c -o selfie.mips32

warnings:
	clang -Wall -m32 -D'main(a, b)=main(int argc, char**argv)' selfie.c -o selfie

emulate:
	./selfie -c selfie.c -d 12
