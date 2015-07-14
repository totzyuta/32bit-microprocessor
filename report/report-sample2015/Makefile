SRCS = report.tex
PLATEX= /usr/local/bin/edu-platex

all: report.pdf

#report.dvi: $(SRCS)
report.pdf: $(SRCS)
	$(PLATEX) report.tex
	$(PLATEX) report.tex

#report.pdf: report.dvi
#	dvipdfmx report.dvi

clean:
	rm -rf *~ *.aux *.log *.dvi report.ps *.euc.tex

distclean: clean.all

clean.all:
	rm -rf *~ *.aux *.log *.dvi report.ps *.euc.tex report.pdf a.pdf

# End of file (Makefile)

