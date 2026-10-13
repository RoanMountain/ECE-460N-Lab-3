; 10_store_timing: checks cycle-level timing of a store. STW's memory
; state (16) runs for 5 cycles, and memory must only change in the 5th.
;   cycles  1-9  : LEA  (8 fetch + 1)
;   cycles 10-18 : ADD
;   cycles 19-26 : STW fetch, 27 = state 7, 28 = state 23 (MDR <- R1),
;                  29-33 = state 16 (memory written in cycle 33)
;   cycles 34-48 : HALT (STW returns to state 18; only STB goes to 19)
        .ORIG x3000
        LEA   R0, BUF
        ADD   R1, R1, #-1     ; R1 = xFFFF
        STW   R1, R0, #0
        HALT
BUF     .FILL x0000           ; at x3008
        .END
