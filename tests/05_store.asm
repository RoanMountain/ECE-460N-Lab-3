; 05_store: STW and STB to even/odd bytes; STB must leave the other byte
; of the word untouched. Also negative offsets and reading the data back.
        .ORIG x3000
        LEA   R0, VALS
        LDW   R1, R0, #0      ; R1 = x1234
        LDW   R2, R0, #1      ; R2 = x56F8
        LEA   R0, BUF
        STW   R1, R0, #0      ; BUF[0] = x1234
        STB   R2, R0, #2      ; byte BUF+2 (even) = xF8 -> BUF[1] = xAAF8
        STB   R2, R0, #5      ; byte BUF+5 (odd)  = xF8 -> BUF[2] = xF8AA
        LEA   R3, VALS        ; R3 = BUF + 8
        STW   R1, R3, #-1     ; BUF[3] = x1234
        STB   R1, R3, #-7     ; byte BUF+1 (odd)  = x34 -> BUF[0] = x3434
        LDW   R4, R0, #1      ; R4 = xAAF8
        LDB   R5, R0, #5      ; R5 = xFFF8 -> final CC: N
        HALT
BUF     .FILL xAAAA
        .FILL xAAAA
        .FILL xAAAA
        .FILL xAAAA
VALS    .FILL x1234
        .FILL x56F8
        .END
