/* (ud_count4.h) */

declare ud_count4 {
    input   down;       /* up/down */
    output  out<4>;     /* sum output (4bit width) */
    output  cout;       /* carry out, 1 if out = 0b1111 & down = 0 */
    output  bout;       /* borrow out, 1 if out = 0b0000 & down = 1 */
    instrin do;         /* control input terminal */

    instr_arg do(down);
}
/* End of file (ud_count4.h) */
