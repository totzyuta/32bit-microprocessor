/* (reg32x8.h) */

%d WIDTH 32      /* date width */
%d ADDR_WIDTH 3  /* address width (log 8) */

declare reg32x8 {
    input   in<WIDTH>;
    input   in_addr<ADDR_WIDTH>;
    input   a_addr<ADDR_WIDTH>;
    input   b_addr<ADDR_WIDTH>;
    output  a<WIDTH>;
    output  b<WIDTH>;
    instrin read_a, read_b, write;

    instr_arg read_a(a_addr);
    instr_arg read_b(b_addr);
    instr_arg write(in_addr, in);
}

/*  End of file (reg32x8.h) */
