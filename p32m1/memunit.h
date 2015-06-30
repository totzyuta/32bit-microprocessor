/* memory unit (memunit.h) */

declare memunit {
    input  inst_addr<32>;    /* instruction memory address */
    output inst_out<32>;     /* instruction code output */

    input  data_addr<32>;    /* data memory address */
    input  data_loc<4>;      /* data location */
    input  data_in<32>;      /* data input */
    output data_out<32>;     /* data output */

    instrin  inst_read;      /* instruction read */
    instrin  data_read;      /* data read */
    instrin  data_write;     /* data write */
    instrout inst_bus_error; /* if instruction address is illegal */
    instrout data_bus_error; /* if data address is illegal */

    instr_arg inst_read(inst_addr);
    instr_arg data_read(data_addr);
    instr_arg data_write(data_addr, data_loc, data_in);
}

/* End of file (memunit.h) */
