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
