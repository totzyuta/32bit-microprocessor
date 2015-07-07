/* (add32.h) */

declare add32 {
    input a<32>;
    input b<32>;
    input cin;       /* carry in */
    output sum<32>;
    output cout;     /* carry out */
    instrin do;

    instr_arg do(a, b, cin);
} /* declare add32 */

/* End of file (add32.h) */
