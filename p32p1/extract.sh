#!/bin/sh

TEMPFILE=/tmp/temp12345.txt
TEMP2FILE=/tmp/temp54321.txt
rm -f ${TEMPFILE} ${TEMP2FILE}
sed '1,/### summary/d' > ${TEMPFILE}
grep "gates      =" ${TEMPFILE} > ${TEMP2FILE}
grep "power      =" ${TEMPFILE} >> ${TEMP2FILE}
grep "area       =" ${TEMPFILE} >> ${TEMP2FILE}
grep "delay path maximum" ${TEMPFILE} >> ${TEMP2FILE}
head -n 4 ${TEMP2FILE}
rm -f ${TEMPFILE} ${TEMP2FILE}
exit 0




