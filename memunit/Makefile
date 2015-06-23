all:	sim

sim:
	seconds < test_memunit_01.sec | tee test_memunit_01.result
	@echo "---"
	@echo "generated test_memunit_01.result"
	@echo "check by 'make diff'!"

diff:	
	diff test_memunit_01.result test_memunit_01.result.sample

synthe:
	@echo "Info: Circuit modules can not be synthesized!!!"
	@echo "---"

clean:
	rm -f *~
	rm -f test_memunit_01.result

# End of file (Makefile)
