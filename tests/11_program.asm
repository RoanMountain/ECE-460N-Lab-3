; 11_program: a small real program. Sums a word array with a loop, then
; copies a zero-terminated byte string with LDB/STB.
        .ORIG x3000
        LEA   R0, ARR
        AND   R1, R1, #0      ; R1 = sum
        AND   R2, R2, #0
        ADD   R2, R2, #5      ; R2 = count
SUM     LDW   R3, R0, #0
        ADD   R1, R1, R3
        ADD   R0, R0, #2
        ADD   R2, R2, #-1
        BRp   SUM             ; R1 = 10 - 3 + 300 + x7000 + 1 = x7134
        LEA   R4, STR
        LEA   R5, DST
COPY    LDB   R3, R4, #0
        STB   R3, R5, #0      ; STB does not change the CCs
        BRz   DONE            ; stop after copying the zero byte
        ADD   R4, R4, #1
        ADD   R5, R5, #1
        BRnzp COPY
DONE    LEA   R6, RES
        STW   R1, R6, #0      ; RES = x7134
        HALT
ARR     .FILL #10
        .FILL #-3
        .FILL #300
        .FILL x7000
        .FILL #1
STR     .FILL x6948           ; "Hi!" : 'H' 'i' '!' 0
        .FILL x0021
DST     .FILL xFFFF           ; becomes x6948, x0021
        .FILL xFFFF
RES     .FILL x0000
        .END
