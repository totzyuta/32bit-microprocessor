all:	sim

sim:
	seconds < test_comp5_01.sec | tee test_comp5_01.result
	@echo "---"
	@echo "generated test_comp5_01.result"
	@echo "check by 'make diff'!"

diff:	
	diff test_comp5_01.result test_comp5_01.result.sample


synthe:
	auto comp5 nld4 DEMO demo | tee comp5.auto_nld4.out

clean:
	rm -f *~
	rm -f test_comp5_01.result comp5.auto_nld4.out
	auto comp5 clean
	rm -f comp5.edif200

# End of file (Makefile)
