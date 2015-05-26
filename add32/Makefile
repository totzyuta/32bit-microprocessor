SECONDS=	seconds
TEMPFILES=	add32_tail.scr add32.scr add32.result

all:	sim

sim:	add32.result

add32.result:	add32.scr
	$(SECONDS) < add32.scr 
	@echo "==========="
	@echo "== generated 'add32.scr'"
	@echo "== check by 'make diff'"

add32.scr: add32_tail.scr add32_head.scr
	cat add32_head.scr add32_tail.scr > add32.scr

add32_tail.scr: 
	./add32.rb genscr > add32_tail.scr

diff:	add32.result
	diff add32.result add32.result.sample

clean:
	rm -f *~ $(TEMPFILES)

