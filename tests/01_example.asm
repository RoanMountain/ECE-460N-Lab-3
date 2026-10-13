; 01_example: the example from the lab handout, checked cycle by cycle.
; Runs "run 1" + "rdump" nine times and compares against the handout's
; dumpsim output (fetch, 5-cycle memory read, decode, AND, back to 18).
        .ORIG x3000
        AND   R0, R0, #0
        HALT
        .END
