/* (alu32.h) */
declare alu32 {
    input   a<32>;
    input   b<32>;
    output  out<32>;
    output  overflow;
    output  zero;
    instrin op_add;
    instrin op_sub;
    instrin op_and;
    instrin op_or;
    instrin op_xor;
    instrin op_nor;

    instr_arg op_add(a, b);
    instr_arg op_sub(a, b);
    instr_arg op_and(a, b);
    instr_arg op_or(a, b);
    instr_arg op_xor(a, b);
    instr_arg op_nor(a, b);
} /* declare alu32 */

/* End of file (alu32.h) */
