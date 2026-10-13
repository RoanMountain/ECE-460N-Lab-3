; 02_alu: ADD, AND, XOR, NOT in register and immediate forms,
; 16-bit wraparound, sign-extended imm5, and condition codes.
        .ORIG x3000
        LEA   R0, DATA
        LDW   R1, R0, #0      ; R1 = x7FFF
        LDW   R2, R0, #1      ; R2 = x00F0
        ADD   R3, R1, #1      ; R3 = x8000  (overflow wraps to negative)
        ADD   R4, R3, R3      ; R4 = x0000  (carry out of bit 15 dropped)
        ADD   R4, R4, #-16    ; R4 = xFFF0  (imm5 sign-extended)
        AND   R5, R4, R2      ; R5 = x00F0
        AND   R5, R5, #15     ; R5 = x0000
        XOR   R6, R1, R2      ; R6 = x7F0F
        XOR   R6, R6, #-1     ; R6 = x80F0
        NOT   R0, R6          ; R0 = x7F0F
        ADD   R1, R1, R2      ; R1 = x80EF  (register-mode add)
        AND   R2, R2, #-16    ; R2 = x00F0  -> final CC: P
        HALT
DATA    .FILL x7FFF
        .FILL x00F0
        .END
