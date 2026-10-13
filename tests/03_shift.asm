; 03_shift: LSHF, RSHFL, RSHFA (on negative and positive values),
; shift by 15 and by 0.
        .ORIG x3000
        LEA   R0, DATA
        LDW   R1, R0, #0      ; R1 = x8421
        LSHF  R2, R1, #4      ; R2 = x4210
        LSHF  R3, R1, #15     ; R3 = x8000
        RSHFL R4, R1, #4      ; R4 = x0842  (zero fill)
        RSHFA R5, R1, #4      ; R5 = xF842  (sign fill)
        RSHFA R6, R1, #15     ; R6 = xFFFF
        RSHFA R0, R2, #8      ; R0 = x0042  (arithmetic shift of a positive value)
        RSHFL R1, R1, #0      ; R1 = x8421  (shift by 0) -> final CC: N
        HALT
DATA    .FILL x8421
        .END
