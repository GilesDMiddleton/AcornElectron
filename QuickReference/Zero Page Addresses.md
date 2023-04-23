# Zero Page Addresses
The zero page on the 6502 is very valuable, and in contention from the OS and other programs. Not only is zero page faster to access (not as fast as registers), but important indirect-indexed addressing modes can only be used with zero page addresss, sadly. Meaning far many more steps than you'd like, but this was the early 1980's.

e.g. if  
&71 contained &58  
&70 contained &00  

```
LDY #1
LDA #255
STA (&70),Y
```
Then 255 is stored at address &5801




Fore deeper information see the [advanced user guide](https://stardot.org.uk/forums/download/file.php?id=79236) 

| Address   | Use                                                                                                                                                                | Can I trample? (empty=avoid)                    |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| &00-&8F   | allocated to the current language (BASIC)                                                                                                                          | YES if you are pure ASM                         |
| ..&70-&8F | BASIC reserved space for users (you)                                                                                                                               | YES                                             |
| &90-&9F   | Econet.                                                                                                                                                            |                                                 |
| ..&90-&96 | Unused (apparently)                                                                                                                                                | Maybe                                           |
| &A0-&A7   | used extensively by the disc and  network filing systems.                                                                                                          |                                                 |
| &A8-&AF   | Used by operating system commands during execution                                                                                                                 | Maybe temporarily, or yes if you do not use OS? |
| &B0-&BF   | filing system scratch space                                                                                                                                        | Maybe if you never load/save                    |
| &C0-&CF   | allocated to the currently active filing system.  This area is nominally private, and will  not be altered unless the filing system is changed                     | Maybe!                                          |
| &D0-&E1   | VDU Driver                                                                                                                                                         |                                                 |
|   &D1     | byte mask for the current graphics point. This byte indicates which bits in the screen memory  byte correspond to the point.  - included this because it's useful! |                                                 |
| &E2       | cassette filing system status byte                                                                                                                                 |                                                 |
| &E3       | cassette filing system options byte                                                                                                                                |                                                 |
| &E4,&E5   | GSREAD?                                                                                                                                                            |                                                 |
| &E6       | OS general use                                                                                                                                                     |                                                 |
| &E7       | auto repeat countdown timer                                                                                                                                        |                                                 |
| &E8,&E9   | pointer to the input buffer into which data  is entered by OSWORD &01                                                                                              |                                                 |
| &EA       | RS423 timeout counter                                                                                                                                              |                                                 |
| &EB       | Bit 7 the 'cassette critical' flag                                                                                                                                 | Maybe!                                          |
| &EC-&EE   | Key pressed info                                                                                                                                                   |                                                 |
| &EF-&F1   | post OSBYTE/OSWORD register values                                                                                                                                 |                                                 |
| &F2,&F3   | text pointer for processing OS commands                                                                                                                            |                                                 |
| &F4       | ROM number of the currently active paged ROM                                                                                                                       |                                                 |
| &F5-&F7   | ROM filing system use                                                                                                                                              |                                                 |
| &F8-&F9   | Not used                                                                                                                                                           | Maybe                                           |
| &FA-&FC   | Interrupt flag use                                                                                                                                                 | Can be used if careful                          |
| &FD,&FE   | Written to after a BRK                                                                                                                                             | Maybe!                                          |
| &FF       | Signals an ESC                                                                                                                                                     |                                                 |
