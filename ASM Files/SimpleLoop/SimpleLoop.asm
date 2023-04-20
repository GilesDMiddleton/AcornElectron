REM SIMPLE LOOPING
AUTO
MODE 5
REM write character to screen using vdu (oswrch)
REM Loops from 255 to 0, each iteration prints ascii 33 to 128
REM
vdu=&FFEE
REM multipass compiler 
FOR I%=0 TO 3 STEP 3
P%=&2000
[OPT I%
.DOLOOP
LDY #255    ; execute 255 times
.YLOOP 
LDX #128    ; ascii chars 33 to 128
.XLOOP
TXA         ; move X to accumulator for CMP and possibly printchar
CMP #33     ; compare accumulator to 33
BMI CONTINUE; if 33 < accumulator do not print. branch past instead of JSR/RTS
JSR vdu
.CONTINUE
DEX         ; decrement X
BNE XLOOP   ; if not reached zero then keep looping
DEY         ; decrement Y counter
BNE YLOOP   ; start X loop again if not finished
RTS         ; back to basic
]
NEXT
REM Comparing call times although VDU is the slowest bit.
REM 30 seconds in basic 
FOR Y%=0  TO 255
    FOR X%=33 TO 128
        VDUX%
NEXT,
REM 17 seconds in ASM.
CALL DOLOOP