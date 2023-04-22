REM LOOP FROM 0 TO 65535
REM Populate TARGET with the value
REM In BBC basic - using TIME - counting to 65535 = 162
REM about 12000 cycles per 255 loop
FOR I%=0 TO 3 STEP 3
P%=&4000
[OPT I%
.MAIN
LDY TARGET      \ Y lobyte of target
BNE MORE2DO
LDX TARGET+1    \ X hibyte of target
BEQ DONE
.MORE2DO
JSR DOSOMEWORK
LDX TARGET+1    \ X hibyte of target
DEY             \ lobyte -1 count down 255-0
STY TARGET
BNE MORE2DO     \ not zero reached 0 keep doing work.
CPX #0          \ was there any hi byte values to procee?
BEQ DONE
LDY #255        \ now is zero so refill lo byte with more work to do
STY TARGET
DEX             \ hibyte -1
STX TARGET+1
JSR DOSOMEWORK
JMP MAIN
.DOSOMEWORK     \just tell me how many times you looped
CLC:LDA ACTUAL:ADC #1:STA ACTUAL:LDA ACTUAL+1:ADC #0:STA ACTUAL+1
RTS
.TARGET
EQUW &0000
EQUW &0000 \ must reserve 2 more empty bytes for basic to interpret 32bit
.ACTUAL
EQUW &0000
EQUW &0000 \ ditto
.DONE
RTS
]
NEXT

!TARGET = 65535

PRINT "BEFORE"
PRINT "TARGET:";!TARGET
PRINT "ACTUAL:";!ACTUAL
TIME = 0
CALL MAIN
PRINT TIME
PRINT "AFTER"
PRINT "TARGET:";!TARGET
PRINT "ACTUAL:";!ACTUAL