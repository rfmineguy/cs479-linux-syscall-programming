.PHONY: clean always build
clean:
	rm -rf out
always:
	mkdir -p out
build: always out/main
out/main: main.s
	$(AS) $^ -o $@.o
	$(LD) $@.o -o $@
