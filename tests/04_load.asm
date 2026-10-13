; 04_load: LDW and LDB at even/odd bytes, sign extension of bytes,
; negative offsets, and DR == BaseR.
        .ORIG x3000
        LEA   R0, DATA
        LDW   R1, R0, #0      ; R1 = x1234
        LDW   R2, R0, #1      ; R2 = x80FF  (offset6 is scaled by 2 for LDW)
        LDB   R3, R0, #0      ; R3 = x0034  (even byte = low byte)
        LDB   R4, R0, #1      ; R4 = x0012  (odd byte = high byte)
        LDB   R5, R0, #2      ; R5 = xFFFF  (xFF sign-extended)
        LDB   R6, R0, #3      ; R6 = xFF80  (x80 sign-extended)
        LEA   R0, ZERO
        LDW   R0, R0, #-2     ; R0 = x1234  (negative offset, DR == BaseR) -> CC: P
        HALT
DATA    .FILL x1234
        .FILL x80FF
ZERO    .FILL x0000
        .END
