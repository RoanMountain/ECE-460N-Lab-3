; 09_trap: TRAP through a vector table to a service routine that returns
; with RET. Loaded with two extra program files:
;   09_trap.svc.asm  (service routine at x4000)
;   09_trap.vec.asm  (vector table entry x20 -> M[x0040] = x4000)
        .ORIG x3000
        TRAP  x20             ; R7 = x3002, PC = M[x0040] = x4000
        ADD   R2, R7, #0      ; R2 = x3002 after the routine returns
        HALT                  ; R7 = x3006, PC = M[x004A] = 0 -> halt
        .END
