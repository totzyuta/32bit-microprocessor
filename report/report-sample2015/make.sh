#!/bin/sh
platex report.tex
dvips report.dvi -o report.ps
ps2pdf report.ps
