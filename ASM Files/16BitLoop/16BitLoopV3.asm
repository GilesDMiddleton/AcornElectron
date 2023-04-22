REM 6502 BBC/Acorn Electron Basic and assembly language
REM This version attempts to use only registers
REM in reality the inner loop and work done there is the only requirement
REM it appears to be T=134 seconds compared to V2 at 162 (18% quicker)
REM or 10,000 cycles for each 255 loop - 20% fewer! than V2

FOR I%=0 TO 3 STEP 3
P%=&4000
[OPT I%
.MAIN
LDY TARGET      \ Y lobyte of target
LDX TARGET+1    \ X hibyte of target
._MAIN
CPY #0
BNE MORE2DO
CPX #0
BEQ DONE
.MORE2DO
JSR DOSOMEWORK
DEY             \ lobyte -1 count down 255-0
BNE MORE2DO     \ not zero reached 0 keep doing work.
CPX #0          \ was there any hi byte values to procee?
BEQ DONE
LDY #255        \ now is zero so refill lo byte with more work to do
DEX             \ hibyte -1
JSR DOSOMEWORK
JMP _MAIN
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
STY TARGET
STX TARGET+1
]
NEXT

!TARGET=65535

PRINT "BEFORE"
PRINT "TARGET:";!TARGET
PRINT "ACTUAL:";!ACTUAL
TIME=0
CALL MAIN
PRINT TIME
PRINT "AFTER"
PRINT "TARGET:";!TARGET
PRINT "ACTUAL:";!ACTUAL