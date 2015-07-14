declare p32p1 {
    output   i_addr<32>;  /* instruction address */
    input    i_data<32>;  /* instruction data */
    instrout i_read;      /* instruction read */

    output   d_addr<32>;  /* data address */
    input    r_data<32>;  /* read data */
    output   wr_data<32>;  /* write data */
    output   w_loc<4>;    /* write location */
    instrout d_read;      /* data read */
    instrout d_write;     /* data write */

    instrin  reset;       /* reset */

    instr_arg reset();
}

/* End of file (p32p1.h) */

