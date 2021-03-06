#
# To simulation, type 'make test' or 'make sim'
# To check simulation result, type 'make diff'
# To clean working files, type 'make clean'
#
MAKEFILE=Makefile.p32p1
SECONDS=seconds

# modify the following lines as your working directory structure
FADD_DIR= ../p32m1
ADD32_DIR=	../add32
ADD4_DIR=	../add32
ALU32_DIR=	../alu32
SHIFT32_DIR=	../shift32
REG32x32_DIR=	../reg32x32
MEMUNIT_DIR=	../memunit
COMP5_DIR=	../comp5

all: test

copy: copy_fulladder copy_add32 copy_alu32 copy_shift32 copy_reg32x32 copy_memunit copy_comp5

copy_fulladder: fulladder.sfl fulladder.h
copy_add32: add32.sfl add32.h add4.sfl add4.h
copy_alu32: alu32.sfl alu32.h
copy_shift32: shift32.sfl shift32.h
copy_reg32x32: reg32x32.sfl reg32x32.h reg32x8.sfl reg32x8.h
copy_memunit: memunit.sfl memunit.h mem64KB.cir mem64KB.h
copy_comp5: comp5.sfl comp5.h

fulladder.sfl: $(FADD_DIR)/fulladder.sfl
	cp $< .
fulladder.h: $(FADD_DIR)/fulladder.h
	cp $< .
add32.sfl: $(ADD32_DIR)/add32.sfl
	cp $< .
add32.h: $(ADD32_DIR)/add32.h
	cp $< .
add4.sfl: $(ADD4_DIR)/add4.sfl
	cp $< .
add4.h: $(ADD4_DIR)/add4.h
	cp $< .
alu32.sfl: $(ALU32_DIR)/alu32.sfl
	cp $< .
alu32.h: $(ALU32_DIR)/alu32.h
	cp $< .
shift32.sfl: $(SHIFT32_DIR)/shift32.sfl
	cp $< .
shift32.h: $(SHIFT32_DIR)/shift32.h
	cp $< .
reg32x32.sfl: $(REG32x32_DIR)/reg32x32.sfl
	cp $< .
reg32x32.h: $(REG32x32_DIR)/reg32x32.h
	cp $< .
reg32x8.sfl: $(REG32x32_DIR)/reg32x8.sfl
	cp $< .
reg32x8.h: $(REG32x32_DIR)/reg32x8.h
	cp $< .
memunit.sfl: $(MEMUNIT_DIR)/memunit.sfl
	cp $< .
memunit.h: $(MEMUNIT_DIR)/memunit.h
	cp $< .
mem64KB.cir: $(MEMUNIT_DIR)/mem64KB.cir
	cp $< .
mem64KB.h: $(MEMUNIT_DIR)/mem64KB.h
	cp $< .
comp5.sfl: $(COMP5_DIR)/comp5.sfl
	cp $< .
comp5.h: $(COMP5_DIR)/comp5.h
	cp $< .


sim:	test

test:	test1 test2 test3

test1:
	$(SECONDS) < test_p32p1_01.sec | tee test_p32p1_01.result

test2:
	$(SECONDS) < test_p32p1_03.sec | tee test_p32p1_03.result

test3:
	$(SECONDS) < test_p32p1_07.sec | tee test_p32p1_07.result

diff:	diff1 diff2 diff3

diff1:
	diff test_p32p1_01.result test_p32p1_01.result.sample | tee diff1.out

diff2:
	diff test_p32p1_03.result test_p32p1_03.result.sample | tee diff2.out

diff3:
	diff test_p32p1_07.result test_p32p1_07.result.sample | tee diff3.out

synthe:
	make -f $(MAKEFILE) clean
	make -f $(MAKEFILE) 2>&1 | tee p32p1.auto.log

spec:
	@if [ -e p32p1.auto.log ]; then \
	  ./extract.sh < p32p1.auto.log; \
	else \
	  echo "*** there is no log file: p32p1.auto.log"; \
	  echo "*** type 'make synthe' first!"; \
	fi

clean:
	rm -f *~
	make -f $(MAKEFILE) clean

distclean:
	rm -f *~
	make -f $(MAKEFILE) clean
	rm -f test_p32p1_0*.result diff*.out p32p1.auto.log

# End of file (Makefile)
