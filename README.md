# UART-verilog
 Simple 8-bit UART realization on Verilog HDL.

operates on 8 bits of serial data, one start bit, one stop bit, one parity bit

supports oversampling by 4 and 8

### IO:

#### control:
* `CLK` - **[input]** board internal clock
* `RST` - **[input]** Synchronized reset signal

#### rx interface:
* `RX_in` - **[input]** Serial Data IN
* `Prescale` - **[input]** Oversampling Prescale
* `PAR_EN` - **[input]** Parity_Enable
* `PAR_TYP` - **[input]** Parity Type
* `P_DATA` - **[output]** received Frame Data Byte
* `Data_valid` - **[output]** Data Byte Valid signal

#### tx interface:
* `P_DATA` - **[input]** Input data byte
* `Data_valid` - **[input]** Input Data Valid signal
* `PAR_EN` - **[input]** Parity_Enable
* `PAR_TYP` - **[input]** Parity Type
* `TX_OUT` - **[output]** Serial Data OUT
* `Busy` - **[output]** High signal during transmission