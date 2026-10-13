; 06_branch: every BR condition, taken and not taken, a BR with nzp = 000,
; and a backward branch loop. Any wrong branch makes R6 non-zero.
        .ORIG x3000
        AND   R6, R6, #0      ; R6 = error count, CC = Z
        BRz   T1              ; taken
        ADD   R6, R6, #1
T1      BRn   FAIL            ; not taken
        BRp   FAIL            ; not taken
        BRnp  FAIL            ; not taken
        ADD   R1, R6, #-3     ; R1 = -3, CC = N
        BRn   T2              ; taken
        ADD   R6, R6, #1
T2      BRzp  FAIL            ; not taken
        BRnz  T3              ; taken
        ADD   R6, R6, #1
T3      ADD   R1, R1, #5      ; R1 = 2, CC = P
        BRp   T4              ; taken
        ADD   R6, R6, #1
T4      BRnz  FAIL            ; not taken
        BRzp  T5              ; taken
        ADD   R6, R6, #1
T5      BRnp  T6              ; taken
        ADD   R6, R6, #1
T6      BRnzp T7              ; taken
        ADD   R6, R6, #1
T7      .FILL x0001           ; BR with n = z = p = 0: never taken
        ADD   R2, R2, #7      ; R2 = 7 (skipped if the BR above is taken)
        AND   R3, R3, #0      ; R3 = 0
        ADD   R4, R3, #5      ; R4 = 5 (loop counter)
LOOP    ADD   R3, R3, #3
        ADD   R4, R4, #-1
        BRp   LOOP            ; backward branch, 5 iterations
        HALT                  ; R3 = 15, R4 = 0, CC = Z
FAIL    ADD   R6, R6, #8      ; reached only by a wrongly taken branch
        HALT
        .END
