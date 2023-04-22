REM 6502 BBC/Acorn Electron Basic and assembly language
REM works fine under 65280 because i did my mod and div wrong
REM This routine does a loop from 0 to TARGET
REM the work in the loop is simply to store the 
REM number of times the loop has executed in the 16bits
REM represented by STORE - lobyte
REM and STORE+1 (hibyte).
REM 6502 is little endian so memory is LLHH
AUTO
MODE 4
TARGET = 65279
R% = TARGET MOD 255
Q% = TARGET/255
FOR I%=0 TO 3 STEP 3
REM storing code on screen for fun
P%=&7000
[OPT 0
.DOLOOP
LDA #0      \ zero our result store for testing only
STA RESULT : STA RESULT+1
LDY #Q%     \ execute N times 255
.YLOOP 
TYA         \ transfer Y to A to test zero
BNE NLAST   \ not the last loop so branch off
LDX #R%     \ is the last so load remainder into X
JMP XLOOP   \ start looping
.NLAST
LDX #255    \ not last so load with full 255 count.
.XLOOP
CLC         \ clear carry so no corruption

LDA RESULT  \ BEGIN PRETEND WORK COULD JSR
ADC #1     \ demo code just counting real executions
STA RESULT
LDA RESULT+1
ADC #0      \ this ensures the carry if any is added to the high byte
STA RESULT+1 \END PRETEND WORK

DEX:BNE XLOOP \ reduce X if not reached zero then keep looping
TYA         \ test Q% isnt zero
BEQ DONE    \ Q is zero, we are done
DEY         \ decrement Y counter
JMP YLOOP   \ start X loop again if not finished
.DONE
RTS         \ back to basic
.RESULT
EQUW &0000
]
NEXT
REM ASM EXECUTES IN 1 SECOND!
CALL DOLOOP
PRINT "REMAINDER       :"?RESULT
PRINT "MULTIPLES OF 256:"?(RESULT+1)
PRINT "TOTAL           :"(?(RESULT+1)*256)+?RESULT
PRINT "TARGET          :"TARGET

PRINT ""
PRINT "NOW THE BASIC VERSION - 150 SECONDS"
STORE=0
FOR NN=0 TO TARGET
STORE=STORE+1
NEXT
