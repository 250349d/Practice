AS = nasm -felf
LD = ld
LDFLAGS = -m elf_i386
OBJS_SQSUM = sqsum.o print_eax.o isprime.o

%.o: %.s
	$(AS) $<

sqsum: $(OBJS_SQSUM)  
	$(LD) $(LDFLAGS) $+ -o $@

.PHONY: clean test

test: sqsum answer.txt
	./sqsum | diff - answer.txt

clean:
	rm -f *.o *~ a.out
