test_sort: sort.o test_sort.s print_eax.s
	nasm -felf test_sort.s
	nasm -felf print_eax.s
	ld -m elf_i386 sort.o test_sort.o print_eax.o -o test_sort

sort.o: sort.s
	nasm -felf sort.s

.PHONY: clean test

clean:
	rm -f *.o *~ a.out test_sort

test: test_sort
	./test_sort
