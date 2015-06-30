/* shifter (shift32.h) */

declare shift32 {
    input in<32>, shamt<5>;
    output out<32>;
    instrin sll; /* shift left logical */
    instrin srl; /* shift right logical */
    instrin sra; /* shift right arithmetic */

    instr_arg sll(in, shamt);
    instr_arg srl(in, shamt);
    instr_arg sra(in, shamt);
}

/* End of file (shift32.h) */
