; Service routine for 09_trap.
        .ORIG x4000
        ADD   R1, R1, #9      ; R1 = 9
        ADD   R3, R7, #0      ; R3 = x3002 (return address)
        RET
        .END
