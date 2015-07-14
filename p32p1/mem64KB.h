/* memory unit (mem64KB.h) */

declare mem64KB {
    input addr<16>;
    input loc<4>;
    input data_in<32>;
    output data_out<32>;
    instrin read, write;

    instr_arg read(addr);
    instr_arg write(addr, loc, data_in);
}

/* End of file (mem64KB.h) */
