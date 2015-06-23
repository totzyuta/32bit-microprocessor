all:	sim

sim:
	seconds < test_reg32x32_01.sec | tee test_reg32x32_01.result
	@echo "---"
	@echo "generated test_reg32x32_01.result"
	@echo "check by 'make diff'!"

diff:	
	diff test_reg32x32_01.result test_reg32x32_01.result.sample


synthe:	synthe.reg32x8.nld1 synthe.reg32x32.nld1
	cp reg32x8.1st/*.nld reg32x32.1st
	auto reg32x32 nld4 DEMO demo | tee reg32x32.auto_nld4.out

synthe.reg32x32.nld1:
	auto reg32x32 nld1 DEMO demo | tee reg32x8.auto_nld1.out

synthe.reg32x8.nld1:
	auto reg32x8 nld1 DEMO demo | tee reg32x8.auto_nld1.out

clean:
	rm -f *~
	rm -f test_reg32x32_01.result reg32x32.auto_nld4.out
	rm -f reg32x8.auto_nld1.out
	auto reg32x32 clean
	auto reg32x8 clean
	rm -f reg32x32.edif200 reg32x8.edif200

# End of file (Makefile)
