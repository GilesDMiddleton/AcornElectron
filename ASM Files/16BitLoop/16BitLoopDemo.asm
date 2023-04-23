REM 6502 BBC/Acorn Electron Basic and assembly language
MODE 4
REM turn off the cursor
VDU 5
FOR I%=0 TO 3 STEP 3
P%=&4000
[OPT 0
.MAIN
\ X% should be lobyte of the screen address
\ Y% should be the hibyte of the screen address
\ see below how that's polulated via HIMEM
\ but after the loops start, X and Y registers are used for loop mechanics
\ F% should be the bit pattern to use
\ TARGET should be the number of 8 bit lines to write.
LDA #00  
STA &72         \ Initialize our drawing counter to 0 COUNTS UP
STY &70         \ transfer Y% to Zero Page lobyte
STX &71         \ transfer X% to Zero Page lobyte
LDY TARGET      \ Y lobyte of target - COUNTS DOWN
LDX TARGET+1    \ X hibyte of target - COUNTS DOWN

._MAIN
CPY #0          \ lobyte depleted?
BNE MORE2DO     \ if not do work
CPX #0          \ are both lo and high are depleted
BEQ DONE

.MORE2DO
JSR DOSOMEWORK
DEY             \ lobyte -1 count down 255-0
BNE MORE2DO     \ not zero reached 0 keep doing work.
CPX #0          \ both low and high byte zero? then done
BEQ DONE
LDY #255        \ now is zero so refill lo byte with more work to do
DEX             \ hibyte -1

JSR DOSOMEWORK  \ make sure to do some work for the high byte deduction
JMP _MAIN       \ NEXT LOOP

.DOSOMEWORK

LDA F%          \ bit pattern to screen
STY &73         \ save existing Y as we need to use it

LDY &72         \ load our 0-255 counter into Y
STA (&70),Y     \ write to screen memory + Y
LDY &73         \ restore old Y reg
JSR _INCSCREENLOBYTE \ unnecessary JSR - just for readability
RTS

._INCSCREENCOUNTER_HIBYTE
\ move zp screen address hibyte along 256 bytes
CLC
LDA &71 
ADC #1
STA &71
RTS

._INCSCREENLOBYTE
STY &73         \ save Y 
LDY &72         \ load our 0-255 lobyte counter into Y
TYA             \ 
CMP #255        \ are we about to flip
BNE CONTINUE    \ no, ok, then increment it and keep trucking
JSR _INCSCREENCOUNTER_HIBYTE \ yes, we need to shift the hibyte

.CONTINUE
INY
STY &72         \ store incremented counter in Y
LDY &73         \ restore Y
RTS
.TARGET
EQUW &0000
EQUW &0000 \ must reserve 2 more empty bytes for basic to interpret 32bit
.DONE
RTS
]
NEXT
REM set F to your fun pattern of bits to fill the screen
?F%=&FF
REM TARGET is the number of blocks to fill * 8 bits
!TARGET=(40*32)*8
REM lobyte of screen
X% = HIMEM DIV 256
Y% = HIMEM MOD 256

REM VDU 19,3,0;0;
CALL MAIN
REM VDU 19,3,7;0;
