AS = nasm -felf
LD = ld
LDFLAGS = -m elf_i386
OBJS_SQSUM = p.o

%.o: %.s
	$(AS) $<

print_eax: $(OBJS_SQSUM)
	$(LD) $(LDFLAGS) $+ -o $@

.PHONY: clean test

test: test_print.o
	$(LD) $(LDFLAGS) $+ -o $@

clean:
	rm -f *.o *~ a.out
