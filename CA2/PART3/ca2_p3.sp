* Full combinational circuit for CA2 - Advanced VLSI
.include "32nm_bulk.pm.txt"

.param VDD = 1.8
.param L = 32n
.param Wn = 32n
.param Wp = '2*Wn'

* Parameters for gate sizing based on logical effort calculations
.param size_nor2_w = 8    * Will be calculated
.param size_nor3 = 3      * Will be calculated
.param size_nand2_j = 2   * Will be calculated
.param size_nand2_out = 2 * Will be calculated
.param size_nand2_k = 2   * Will be calculated
.param size_inv_n = 26    * Given in the problem

Vdd vdd 0 DC 'VDD'
* Correct rise/fall time to 0.01ns
Vin A 0 PULSE(0 'VDD' 0 0.01n 0.01n 0.5n 1.0n)

* Subcircuit definitions

* Inverter
.subckt inverter in out vdd 0 size=1
Mp out in vdd vdd pmos W='Wp*size' L='L'
Mn out in 0   0   nmos W='Wn*size' L='L'
.ends

* NAND2 gate
.subckt nand2 a b out vdd 0 size=1
Mp1 out a vdd vdd pmos W='Wp*size' L='L'
Mp2 out b vdd vdd pmos W='Wp*size' L='L'
Mn1 out a net1 0   nmos W='2*Wn*size' L='L'
Mn2 net1 b 0   0   nmos W='2*Wn*size' L='L'
.ends

* NOR3 Gate
.subckt nor3 a b c out vdd 0 size=1
Mp1 out a net1 vdd pmos W='3*Wp*size' L='L'
Mp2 net1 b net2 vdd pmos W='3*Wp*size' L='L'
Mp3 net2 c vdd vdd pmos W='3*Wp*size' L='L'
Mn1 out a 0 0 nmos W='Wn*size' L='L'
Mn2 out b 0 0 nmos W='Wn*size' L='L'
Mn3 out c 0 0 nmos W='Wn*size' L='L'
.ends

* NOR2 Gate
.subckt nor2 a b out vdd 0 size=1
Mp1 out a net1 vdd pmos W='2*Wp*size' L='L'
Mp2 net1 b vdd vdd pmos W='2*Wp*size' L='L'
Mn1 out a 0 0 nmos W='Wn*size' L='L'
Mn2 out b 0 0 nmos W='Wn*size' L='L'
.ends

* --- Netlist main circuit ---

* Step 1: w = NOR2(A, 0)
Vgnd0_1 z1 0 DC 0             
Xnor2_gate A z1 w vdd 0 nor2 size='size_nor2_w'

* Step 2: i = NOR3(w, 0, 0)
Vgnd0_2 z2 0 DC 0
Vgnd0_3 z3 0 DC 0
Xnor_i w z2 z3 i vdd 0 nor3 size='size_nor3'

* Step 3: x = NOR3(w, 0, 0)
Vgnd0_4 z4 0 DC 0
Vgnd0_5 z5 0 DC 0
Xnor_x w z4 z5 x vdd 0 nor3 size='size_nor3'

* Step 4: j = NOR3(w, 0, 0)
Vgnd0_6 z6 0 DC 0
Vgnd0_7 z7 0 DC 0
Xnor_j w z6 z7 j vdd 0 nor3 size='size_nor3'

* Step 5: k = NAND2(1, x)
Vvdd1_1 z8 0 DC 'VDD'             
Xnand2_k z8 x k vdd 0 nand2 size='size_nand2_j'

* Step 6: out = NAND2(x, 1)
Vvdd1_2 z9 0 DC 'VDD'              
Xnand2_out x z9 out vdd 0 nand2 size='size_nand2_out'

* Step 7: l = NAND2(x, 1)
Vvdd1_3 z10 0 DC 'VDD'             
Xnand2_l x z10 l vdd 0 nand2 size='size_nand2_k'

* Step 8: n1 = NOT(out)
Xinv_n1 out n1 vdd 0 inverter size= 13

* Step 9: out2 = NOT(n1)
Xinv_out2 n1 out2 vdd 0 inverter size= 32

* Step 10: n = NOT(out2)
Xinv_n out2 n vdd 0 inverter size='size_inv_n'

* Cap load - based on the problem statement
Cl n 0 78f

* Transient analysis
.tran 1p 10n

* Measurements for all nodes
.measure tran delay_w_HL TRIG v(A) VAL='VDD/2' RISE=1 TARG v(w) VAL='VDD/2' FALL=1
.measure tran delay_w_LH TRIG v(A) VAL='VDD/2' FALL=1 TARG v(w) VAL='VDD/2' RISE=1
.measure tran tpd_w param='(delay_w_HL+delay_w_LH)/2'
************************************
.measure tran delay_i_LH TRIG v(w) VAL='VDD/2' FALL=1 TARG v(i) VAL='VDD/2' RISE=1
.measure tran delay_i_HL TRIG v(w) VAL='VDD/2' RISE=1 TARG v(i) VAL='VDD/2' FALL=1
.measure tran tpd_i param='(delay_i_HL+delay_i_LH)/2'
****************************************
.measure tran delay_x_LH TRIG v(w) VAL='VDD/2' FALL=1 TARG v(x) VAL='VDD/2' RISE=1
.measure tran delay_x_HL TRIG v(w) VAL='VDD/2' RISE=1 TARG v(x) VAL='VDD/2' FALL=1
.measure tran tpd_x param='(delay_x_HL+delay_x_LH)/2'
*****************************************
.measure tran delay_j_HL TRIG v(w) VAL='VDD/2' RISE=1 TARG v(j) VAL='VDD/2' FALL=1
.measure tran delay_j_LH TRIG v(w) VAL='VDD/2' FALL=1 TARG v(j) VAL='VDD/2' RISE=1
.measure tran tpd_j param='(delay_j_HL+delay_j_LH)/2'
*********************************************
.measure tran delay_k_HL TRIG v(x) VAL='VDD/2' RISE=1 TARG v(k) VAL='VDD/2' FALL=1
.measure tran delay_k_LH TRIG v(x) VAL='VDD/2' FALL=1 TARG v(k) VAL='VDD/2' RISE=1
.measure tran tpd_K param='(delay_K_HL+delay_K_LH)/2'
**********************************************
.measure tran delay_out_HL TRIG v(x) VAL='VDD/2' RISE=1 TARG v(out) VAL='VDD/2' FALL=1
.measure tran delay_out_LH TRIG v(x) VAL='VDD/2' FALL=1 TARG v(out) VAL='VDD/2' RISE=1
.measure tran tpd_out param='(delay_out_HL+delay_out_LH)/2'
*************************************************
.measure tran delay_l_HL TRIG v(x) VAL='VDD/2' RISE=1 TARG v(l) VAL='VDD/2' FALL=1
.measure tran delay_l_LH TRIG v(x) VAL='VDD/2' FALL=1 TARG v(l) VAL='VDD/2' RISE=1
.measure tran tpd_l param='(delay_out_HL+delay_out_LH)/2'
*****************************************************
.measure tran delay_n1_LH TRIG v(out) VAL='VDD/2' FALL=1 TARG v(n1) VAL='VDD/2' RISE=1
.measure tran delay_n1_HL TRIG v(out) VAL='VDD/2' RISE=1 TARG v(n1) VAL='VDD/2' FALL=1
.measure tran tpd_n1 param='(delay_n1_HL+delay_n1_LH)/2'
*********************************************************
.measure tran delay_out2_LH TRIG v(n1) VAL='VDD/2' FALL=1 TARG v(out2) VAL='VDD/2' RISE=1
.measure tran delay_out2_HL TRIG v(n1) VAL='VDD/2' RISE=1 TARG v(out2) VAL='VDD/2' FALL=1
.measure tran tpd_out2 param='(delay_out2_HL+delay_out2_LH)/2'
************************************************************

* Output node rise and fall time
.measure tran trise_out2 TRIG v(out2) VAL='0.1*VDD' RISE=1 TARG v(out2) VAL='0.9*VDD' RISE=1
.measure tran tfall_out2 TRIG v(out2) VAL='0.9*VDD' FALL=1 TARG v(out2) VAL='0.1*VDD' FALL=1

* Total path delay
.measure tran tpdr TRIG v(A) VAL='VDD/2' RISE=1 TARG v(out2) VAL='VDD/2' FALL=1
.measure tran tpdf TRIG v(A) VAL='VDD/2' FALL=1 TARG v(out2) VAL='VDD/2' RISE=1

* Path delay components
.measure tran total_delay_out param='tpd_w+tpd_x+tpd_out'
.measure tran total_delay_out2 param='tpd_w+tpd_x+tpd_out+tpd_n1+tpd_out2'

* Power measurement
.measure tran Pavg AVG POWER FROM=0n TO=10n


* alter the size of NOR3 
.alter
.param size_nor3 = 1
.tran 1p 10n

* alter the size of NOR3 
.alter
.param size_nor3 = 2 
.tran 1p 10n

* alter the size of NOR3 
.alter
.param size_nor3 = 3
.tran 1p 10n

* alter the size of NOR3 
.alter
.param size_nor3 = 4
.tran 1p 10n

* alter the size of NOR3 
.alter
.param size_nor3 = 5
.tran 1p 10n

* alter the size of NOR3 
.alter
.param size_nor3 = 6 
.tran 1p 10n

* alter the size of NOR3 
.alter
.param size_nor3 = 7 
.tran 1p 10n

* alter the size of NOR3 
.alter
.param size_nor3 = 8
.tran 1p 10n

* alter the size of NOR3 
.alter
.param size_nor3 = 9 
.tran 1p 10n

* alter the size of NOR3 
.alter
.param size_nor3 = 10 
.tran 1p 10n

* Plot commands for visualization
*.plot tran v(A) v(w) v(i) v(x) v(j) v(k) v(out) v(n)
.option post=2

.end