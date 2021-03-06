#
# sort1.s
#       
        INITIAL_GP = 0x10008000
        INITIAL_SP = 0x7ffffffc
        # system call service number
        stop_service = 99

        .text
init:
        # initialize $gp (global pointer) and $sp (stack pointer)
        la      $gp, INITIAL_GP         # $gp <- 0x10008000 (INITIAL_GP)
        la      $sp, INITIAL_SP         # $sp <- 0x7ffffffc (INITIAL_SP)
        jal     main                    # jump to `main'
        nop                             #   (delay slot)
        li      $v0, stop_service       # $v0 <- 99 (stop_service)
        syscall                         # halt
        nop
        # not reach here
stop:                                   # if syscall return 
        j stop                          # infinite loop...
        nop


        .text   0x00001000
main:
        sw      $ra, 0($sp)             # save $ra to stack
        la      $a0, DATA               # $a0 <- base address of data
        la      $t0, N_DATA             # $t0 <- &n
        lw      $a1, 0($t0)             # $a1 <- n
        nop                             #   (delay slot)
        jal     sort1
        nop                             #   (delay slot)
#       sw      $v0, 0xc000($gp)        # mem[0x10004000] <- $v0
        lw      $ra, 0($sp)             # restore $ra to stack
        nop                             #   (delay slot)
        jr      $ra                     # return from `main'
        nop                             #   (delay slot)

        .text   0x00002000
        # stack frame layout
        framesize = 36                  # スタックフレームのサイズ
        ra_loc = 32                     # $ra を保存するフレーム内の位置
        fp_loc = 28                     # $fp を保存するフレーム内の位置
	# ...
sort1:

	add	$v0, $a0, $zero		# $v0 = data;
	li	$a2, 0			# $a2 : left = 0
	addi	$a3, $a1, -1		# $a3 : right = n-1
qsort:
        addi    $sp, $sp, -framesize    # allocate new stack frame
        sw      $ra, ra_loc($sp)        # save $ra to stack frame
        sw      $fp, fp_loc($sp)        # save $fp to stack frame
        ori     $fp, $sp, 0             # $fp <- $sp
	# 保存する必要のあるレジスタがあればここで復帰しておく

##
#       ここにソーティングのコードを書く
#       ($spを破壊してはいけない)
#       結果（ソート済みデータの先頭アドレス）は $v0 に格納
#
##
	addi	$t0, $a2, 0		# $t0 : i = left
	addi	$t1, $a3, 0		# $t1 : j = right

	# pivot($t2) = data($a0)[right($a3)];
	sll	$t3, $a3, 2
	add	$t3, $t3, $a0
	lw	$t2, 0($t3)
	nop				# delay slot

loop:

i_pivot:
	# pivot($t2) < data($a0)[i($t0)];
	sll	$t3, $t0, 2
	addu	$t3, $t3, $a0
	lw	$t3, 0($t3)
	nop				# delay slot
	slt	$t3, $t2, $t3
	beq	$t3, $zero, i_pivot_end
	nop				# delay slot

	# i($t0)++;
	addi	$t0, $t0, 1

	j	i_pivot
	nop				# delay slot
i_pivot_end:

j_pivot:
	# data($a0)[j($t1)] < pivot($t2);
	sll	$t3, $t1, 2
	addu	$t3, $t3, $a0
	lw	$t3, 0($t3)
	nop				# delay slot
	slt	$t3, $t3, $t2
	beq	$t3, $zero, j_pivot_end
	nop				# delay slot

	# j($t1)--;
	addi	$t1, $t1, -1

	j	j_pivot
	nop				# delay slot
j_pivot_end:

	# if !(i($t0) < j($t1)) break;
	slt	$t3, $t0, $t1
	beq	$t3, $zero, loop_end

	# swap data($a0)[i($t0)], data($a0)[j($t1)]
	sll	$t3, $t0, 2
	addu	$t3, $t3, $a0
	lw	$t5, 0($t3)
	nop				# delay slot

	sll	$t4, $t1, 2
	addu	$t4, $t4, $a0
	lw	$t6, 0($t4)
	nop				# delay slot

	sw	$t5, 0($t4)
	sw	$t6, 0($t3)
	# swap end

	# i($t0)++;
	addi	$t0, $t0, 1

	# j($t1)--;
	addi	$t1, $t1, -1

	j	loop
	nop				# delay slot
loop_end:

	# save to stack
	sw	$t1, 16($sp)		# j
	sw	$a3, 20($sp)		# right

	# right($a3) = i($t0) - 1;
	addi	$a3, $t0, -1

	# if !(left($a2) < i-1($a3)) skip;
	slt	$t3, $a2, $a3
	beq	$t3, $zero, skip1
	nop				# delay slot

	# qsort(left, i-1)
	jal	qsort
	nop				# delay slot
skip1:

	# load from stack
	lw	$a2, 16($sp)		# j
	lw	$a3, 20($sp)		# right
	nop				# delay slot

	# j = j + 1;
	addi	$a2, $a2, 1

	# if !(j+1($a2) < right($a3)) skip;
	slt	$t3, $a2, $a3
	beq	$t3, $zero, skip2
	nop				# delay slot

	# qsort(j+1, right)
	jal	qsort
	nop				# delay slot
skip2:

	# 復帰する必要のあるレジスタがあればここで復帰しておく
        or      $sp, $fp, $fp           # $sp <- $fp 
        lw      $fp, fp_loc($sp)        # restore $fp from stack frame
        lw      $ra, ra_loc($sp)        # restore $ra from stack fram
        addi    $sp, $sp, framesize     # deallocate stack frame
        jr      $ra                     # return from subroutine `sort1'
        nop                             #   (delay slot)


        .data   0x10004000
N_DATA: .word   16                      # データの個数
DATA:   .word   1, 2, 3, 4, 5, 6, 7, 8           # ソートするデータ
        .word   9, 10, 11, 12, 13, 14, 15, 16    # ソートするデータ(続き)
# End of file (sort1.s) 
