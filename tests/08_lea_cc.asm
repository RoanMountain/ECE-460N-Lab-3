; 08_lea_cc: LEA with negative and positive offsets; LEA must NOT
; change the condition codes.
        .ORIG x3000
FIRST   AND   R0, R0, #0      ; CC = Z
        LEA   R1, FIRST       ; R1 = x3000 (negative offset), CC still Z
        BRz   OK1
        ADD   R6, R6, #1
OK1     ADD   R2, R2, #-1     ; R2 = xFFFF, CC = N
        LEA   R3, LAST        ; R3 = address of LAST, CC still N
        BRn   OK2
        ADD   R6, R6, #1
OK2     HALT                  ; R6 = 0 if LEA left the CCs alone
LAST    .FILL x0000
        .END
