; 07_jsr_jmp: JSR (forward and backward), JSRR, RET, JMP, and JSRR R7,
; which must jump to the old R7 before R7 gets the return address.
        .ORIG x3000
        BRnzp MAIN
SUB0    ADD   R1, R1, #8      ; reached with a negative JSR offset
        RET
MAIN    JSR   SUB0            ; R1 = 8
        LEA   R0, SUB2
        JSR   SUB1            ; R1 = 9, R5 = address of A1
A1      JSRR  R0              ; R2 = 2
        LEA   R7, SUB3
        JSRR  R7              ; R3 = 3, R0 = address of A3
A3      LEA   R4, DONE
        JMP   R4
        ADD   R6, R6, #1      ; skipped by the JMP
DONE    HALT
SUB1    ADD   R1, R1, #1
        ADD   R5, R7, #0      ; R5 = return address (A1)
        RET
SUB2    ADD   R2, R2, #2
        RET
SUB3    ADD   R3, R3, #3
        ADD   R0, R7, #0      ; R0 = return address (A3)
        RET
        .END
