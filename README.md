# ECE-460N-Lab-3
For this assignment, you will write a cycle-level simulator for the LC-3b. The simulator will take two input files:
- A file entitled ucode3 which holds the control store.
- A file entitled isaprogram which is an assembled LC-3b program.
The simulator will execute the input LC-3b program, using the microcode to direct the simulation of the microsequencer, datapath, and memory components of the LC-3b.
 
Note: The file isaprogram is the output file from Lab Assignment 1. This file should consist of 4 hex characters per line. Each line of 4 hex characters should be prefixed with '0x'. For example, the instruction NOT R1, R6 would have been assembled to 1001001110111111. This instruction would be represented in the isaprogram file as 0x93BF. The file ucode3 is an ASCII file that consists of 64 rows and 35 columns of zeros and ones.
 
The simulator is partitioned into two main sections: the shell and the simulation routines. We are providing you with the shell. Your job is to write the simulation routines.
