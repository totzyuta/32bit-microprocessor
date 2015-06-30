/* (reg32x32.h) */

/* bit width of each registers */
%d DATA_WIDTH 32
%d ADDR_WIDTH 5

declare reg32x32 {
    input   in<DATA_WIDTH>;    
    input   in_addr<ADDR_WIDTH>;   
    input   a_addr<ADDR_WIDTH>;
    input   b_addr<ADDR_WIDTH>;
    output  a<DATA_WIDTH>;
    output  b<DATA_WIDTH>;
    instrin read_a, read_b, write;

    instr_arg read_a(a_addr);
    instr_arg read_b(b_addr);
    instr_arg write(in_addr, in);
}

/* End of file (reg32x32.h) */
