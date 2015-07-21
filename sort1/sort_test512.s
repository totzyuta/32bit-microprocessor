#
# (sort_test512.s)
#
	INITIAL_GP = 0x10008000
	INITIAL_SP = 0x7ffffffc
	# system call service number
	print_int = 1 
	print_string = 4
	stop_service = 99

	.text
init:
	# initialize $gp (global pointer) and $sp (stack pointer)
	la	$gp, INITIAL_GP		# $gp <- 0x10008000 (INITIAL_GP)
	la	$sp, INITIAL_SP		# $sp <- 0x7ffffffc (INITIAL_SP)
	jal	main			# jump to `main'
	nop				#   (delay slot)
	li	$v0, stop_service	# stop
	syscall				# 
	nop
stop:					# if syscall return 
	j stop				# infinite loop...
	nop				#   (delay slot)

	.text	0x00001000
main:
	sw	$ra, 0($sp)		# save $ra to stack
	la	$a0, DATA		# $a0 <- base address of data
	la	$t0, N_DATA		# $t0 <- &n
	lw	$a1, 0($t0)		# $a1 <- n
	nop				#   (delay slot)
	jal	sort1			# jump to sorting routine
	nop				#   (delay slot)

	# 性能測定時には下記の5行をコメントアウト
	or	$a0, $v0, $v0
	la	$t0, N_DATA		# $t0 <- &n
	lw	$a1, 0($t0)
	jal	check			# チェックルーチンをコール
	nop				#   (delay slot)
	# 
	
	lw	$ra, 0($sp)		# restore $ra to stack
	nop				#   (delay slot)
	jr	$ra
	nop				#   (delay slot)


	.text	0x00002000
	# sort routine
sort1:
#
#
#	!!! write here !!!
#
#
	jr	$ra			# return to caller (main)
	nop				#   (delay slot)


	#
	# check routine
	#   input: $a0 ... start address of sorted data
	#          $a1 ... number of data
	#
	# *** DO NOT MODIFY THIS ROUTINE ***
	#
check:
	ori	$s0, $a0, 0		# $a0 <- $s0
	li	$v0, print_string	# print_string
	la	$a0, NUM_DATA_MESSAGE
	syscall				# print "number of data: "
	li	$v0, print_int
	ori	$a0, $a1, 0		# $a0 <- $a1
	syscall				# print number of date (N)
	li	$v0, print_string	# print_string
	la	$a0, CHECK_MESSAGE
	syscall				# print "checking ... "

	xor	$s1, $s1, $s1		# $s1 <- 0  (check sum)
	lw	$t1, 0($s0)
	addi	$a1, $a1, -1
	addi	$s0, $s0, 4
	add	$s1, $s1, $t1		# $s1 <- $s1 + $t1
$L910:
	beq	$a1, $zero, $OK
	lw	$t2, 0($s0)
	nop				#   (delay slot)
	slt	$t0, $t1, $t2
	bne	$t0, $zero, $FAIL
	nop				#   (delay slot)
	or	$t1, $t2, $t2
	addi	$a1, $a1, -1
	addi	$s0, $s0, 4
	add	$s1, $s1, $t1		# $s1 <- $s1 + $t1
	j	$L910
	nop				#   (delay slot)
$FAIL:
	# 結果が正しくない場合
	li	$v0, print_string	# print_string
	la	$a0, FAIL_MESSAGE	
	syscall
	li	$v0, print_int
	ori	$a0, $t1, 0
	syscall
	li	$v0, print_string	# print_string
	la	$a0, SPACE_MESSAGE	
	syscall
	li	$v0, print_int
	ori	$a0, $t2, 0
	syscall	
	li	$v0, print_string	# print_string
	la	$a0, CR_MESSAGE	
	syscall
	nop
	andi	$v0, $zero, -1		# $v0レジスタを0xffffffff に設定
	j	$L911
	nop				#   (delay slot)
$OK:
	# 結果が正しい場合
	li	$v0, print_string	# print_string
	la	$a0, OK_MESSAGE
	syscall
	nop
	andi	$v0, $zero, 0		# $v0レジスタを 0 に設定
$L911:
	# check sum を表示
	li	$v0, print_string	# print_string
	la	$a0, CHECK_SUM_MESSAGE
	syscall
	li	$v0, print_int
	ori	$a0, $s1, 0
	syscall	
	li	$v0, print_string	# print_string
	la	$a0, CR_MESSAGE	
	syscall
	nop
	jr	$ra			# リターンする
	nop				#   (delay slot)

	.data
NUM_DATA_MESSAGE:
	.asciiz "number of data: "
CHECK_MESSAGE:
	.asciiz "\nchecking ... "
OK_MESSAGE:
	.asciiz	"OK.\n"
FAIL_MESSAGE:	
	.asciiz	"fail.\n"
SPACE_MESSAGE:	
	.asciiz	" "
CR_MESSAGE:	
	.asciiz	"\n"
CHECK_SUM_MESSAGE:	
	.asciiz	"check sum: "

	# data segment
	.data	0x10004000
N_DATA:	.word	512			# number of data

	# *** DO NOT MODIFY FOLLOWING DATA ***
DATA:	.word	970
	.word	1627
	.word	1070
	.word	218
	.word	477
	.word	1707
	.word	1694
	.word	1334
	.word	687
	.word	1064
	.word	1775
	.word	1548
	.word	1912
	.word	1436
	.word	1794
	.word	1800
	.word	2015
	.word	1462
	.word	1445
	.word	2033
	.word	481
	.word	297
	.word	1574
	.word	1721
	.word	1489
	.word	162
	.word	507
	.word	1417
	.word	1425
	.word	901
	.word	1929
	.word	1756
	.word	1819
	.word	1676
	.word	1293
	.word	994
	.word	1204
	.word	967
	.word	238
	.word	1756
	.word	1160
	.word	1196
	.word	1094
	.word	737
	.word	2012
	.word	57
	.word	747
	.word	106
	.word	1526
	.word	1595
	.word	1499
	.word	1376
	.word	500
	.word	258
	.word	1114
	.word	1214
	.word	1724
	.word	371
	.word	836
	.word	1064
	.word	350
	.word	259
	.word	1136
	.word	535
	.word	1644
	.word	1219
	.word	1285
	.word	287
	.word	215
	.word	1223
	.word	1518
	.word	160
	.word	558
	.word	505
	.word	1491
	.word	448
	.word	734
	.word	1982
	.word	1576
	.word	1291
	.word	427
	.word	1916
	.word	689
	.word	1621
	.word	398
	.word	1636
	.word	972
	.word	1648
	.word	1120
	.word	1120
	.word	679
	.word	1468
	.word	887
	.word	196
	.word	1043
	.word	1163
	.word	337
	.word	760
	.word	770
	.word	1100
	.word	957
	.word	962
	.word	198
	.word	876
	.word	917
	.word	1711
	.word	1121
	.word	1865
	.word	228
	.word	223
	.word	1709
	.word	399
	.word	450
	.word	1358
	.word	433
	.word	1427
	.word	475
	.word	938
	.word	572
	.word	1470
	.word	1353
	.word	376
	.word	1045
	.word	444
	.word	1147
	.word	470
	.word	30
	.word	694
	.word	225
	.word	1048
	.word	1558
	.word	323
	.word	887
	.word	1760
	.word	2010
	.word	1850
	.word	659
	.word	1153
	.word	1219
	.word	194
	.word	942
	.word	1672
	.word	287
	.word	646
	.word	1712
	.word	883
	.word	1869
	.word	1279
	.word	569
	.word	476
	.word	1909
	.word	1577
	.word	1231
	.word	995
	.word	1164
	.word	1347
	.word	1286
	.word	316
	.word	1227
	.word	16
	.word	1829
	.word	1335
	.word	538
	.word	1047
	.word	1937
	.word	751
	.word	283
	.word	324
	.word	1789
	.word	1474
	.word	562
	.word	108
	.word	1153
	.word	252
	.word	1155
	.word	2040
	.word	1706
	.word	460
	.word	1077
	.word	616
	.word	758
	.word	650
	.word	399
	.word	1491
	.word	580
	.word	761
	.word	1953
	.word	1162
	.word	1069
	.word	1228
	.word	1794
	.word	1523
	.word	1205
	.word	1476
	.word	688
	.word	899
	.word	671
	.word	1416
	.word	839
	.word	257
	.word	1517
	.word	1794
	.word	1039
	.word	1306
	.word	2045
	.word	1393
	.word	2007
	.word	177
	.word	463
	.word	408
	.word	781
	.word	148
	.word	676
	.word	815
	.word	39
	.word	1897
	.word	1364
	.word	1370
	.word	633
	.word	426
	.word	1449
	.word	155
	.word	1637
	.word	1104
	.word	127
	.word	714
	.word	187
	.word	414
	.word	102
	.word	695
	.word	15
	.word	2024
	.word	45
	.word	1198
	.word	780
	.word	279
	.word	918
	.word	576
	.word	1425
	.word	337
	.word	642
	.word	1970
	.word	665
	.word	148
	.word	550
	.word	1569
	.word	629
	.word	190
	.word	897
	.word	537
	.word	41
	.word	1183
	.word	929
	.word	739
	.word	1863
	.word	32
	.word	1453
	.word	314
	.word	1586
	.word	1741
	.word	1213
	.word	551
	.word	802
	.word	2041
	.word	979
	.word	186
	.word	446
	.word	1112
	.word	182
	.word	917
	.word	259
	.word	815
	.word	1515
	.word	2016
	.word	70
	.word	1894
	.word	853
	.word	1283
	.word	1100
	.word	579
	.word	720
	.word	1001
	.word	889
	.word	156
	.word	37
	.word	639
	.word	128
	.word	943
	.word	958
	.word	822
	.word	1122
	.word	784
	.word	1801
	.word	2017
	.word	548
	.word	1298
	.word	1272
	.word	1108
	.word	1180
	.word	1509
	.word	394
	.word	1196
	.word	433
	.word	1785
	.word	159
	.word	1321
	.word	1820
	.word	986
	.word	1628
	.word	192
	.word	1544
	.word	828
	.word	1435
	.word	590
	.word	530
	.word	675
	.word	587
	.word	1003
	.word	314
	.word	1180
	.word	1215
	.word	1131
	.word	153
	.word	385
	.word	1640
	.word	1159
	.word	394
	.word	1291
	.word	420
	.word	408
	.word	1372
	.word	158
	.word	883
	.word	399
	.word	130
	.word	1831
	.word	877
	.word	810
	.word	1822
	.word	189
	.word	431
	.word	789
	.word	859
	.word	1725
	.word	904
	.word	1250
	.word	1304
	.word	1378
	.word	756
	.word	198
	.word	658
	.word	945
	.word	1455
	.word	371
	.word	817
	.word	558
	.word	638
	.word	289
	.word	609
	.word	661
	.word	1237
	.word	347
	.word	1468
	.word	1853
	.word	799
	.word	1381
	.word	737
	.word	1578
	.word	1111
	.word	1151
	.word	270
	.word	1876
	.word	180
	.word	1433
	.word	1287
	.word	1392
	.word	942
	.word	1170
	.word	807
	.word	1631
	.word	1344
	.word	1506
	.word	308
	.word	632
	.word	1293
	.word	1591
	.word	1291
	.word	1585
	.word	1267
	.word	617
	.word	1275
	.word	1771
	.word	1212
	.word	235
	.word	1469
	.word	926
	.word	1618
	.word	324
	.word	1991
	.word	1132
	.word	1972
	.word	557
	.word	662
	.word	1557
	.word	1292
	.word	594
	.word	385
	.word	42
	.word	989
	.word	1780
	.word	1973
	.word	102
	.word	1695
	.word	989
	.word	721
	.word	668
	.word	905
	.word	1892
	.word	1905
	.word	529
	.word	1939
	.word	1962
	.word	1154
	.word	1599
	.word	21
	.word	998
	.word	307
	.word	1371
	.word	1865
	.word	1928
	.word	679
	.word	535
	.word	1396
	.word	22
	.word	1760
	.word	1968
	.word	1676
	.word	466
	.word	122
	.word	1852
	.word	273
	.word	1941
	.word	1000
	.word	1856
	.word	658
	.word	1596
	.word	900
	.word	791
	.word	737
	.word	734
	.word	604
	.word	618
	.word	785
	.word	281
	.word	1912
	.word	761
	.word	1714
	.word	1556
	.word	208
	.word	926
	.word	1493
	.word	1977
	.word	70
	.word	157
	.word	1684
	.word	625
	.word	1936
	.word	1631
	.word	1494
	.word	734
	.word	1358
	.word	661
	.word	1289
	.word	861
	.word	1221
	.word	182
	.word	1557
	.word	1301
	.word	1822
	.word	1819
	.word	1764
	.word	835
	.word	1318
	.word	1766
	.word	639
	.word	450
	.word	284
	.word	953
	.word	290
	.word	323
	.word	645
	.word	1613
	.word	526
	.word	1782
	.word	381
	.word	18
	.word	1715
	.word	84
	.word	554
	.word	1910
	.word	1441
	.word	1944
	.word	1120
	.word	1704
	.word	1294
	.word	496
	.word	723
	.word	1749
	.word	1704
	.word	1340
	.word	599
	.word	723
# End of file (sort_test512.s)
