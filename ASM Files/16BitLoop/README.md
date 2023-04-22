# Loop mechanisms
Remember these are not perfect examples, they're charting the evolution of my understanding. They do, however, get progressively better and faster.
The intention is to be able to do some work within the range of
```
FOR I%=0 TO 65535
   do something
NEXT
```

All these loops demonstrate storing the number of times iterated in a 16bit integer

## 16BitLoop
My first attempt was wrong, but worked upto 65280. 
Notable features are
* using EQUW to store the two byte result available in Basic as RESULT
* Using the memory of TARGET to decrement the loop counter
* Continually updating the memory in RESULT - simulating some work.

# 16BitLoopV2
This is the first version that actually supports looping to 65535
Notable features are
* It still modifies TARGET unnecessarily
* It's faster
* Demonstrates setting 32bit memory of target with !TARGET=value

# 16BitLoopV3
After reviewing the code, and seeing some rad suggestions by Chat-GPT which didn't work, but inspired me, I decided to focus on performance.
Notable features
* 20% faster
* Y register represents the low byte of the 16bit target value
* X register represents the high byte of the 16bit target value
* X and Y are decremented, TARGET is never touched
* Moved "I'm done" checking early on
* Removed unnecessary re-loading and restoring of memory from TARGET
* TARGET is not updated

# 16BitLoop future ideas
* Allow the loop to start from any 16bit starting point
* Error checking i.e.
    * START<TARGET
* Count down instead of count up
* Passing address of work to execute and maybe pushing X and Y and popping
* Obviously the more flexible a loop becomes the slower it may work - games of this era value small code *and* speed thus small loops may be better unrolled (repeat your statements). E.g. don't use this method to do something 3 times, instead do 
```
JSR subroutine \ if your subroutine needs to know the iteration count
JSR subroutine \ then adopt the X Y regsiter paradigm above.
JSR subroutine
``` 
* Work out how to pass more parameters to the sub routine e.g. CALL doloop,100,400,something
* that is Loops I=100 to 400, what's best practice to set up the 'something' that the subroutine may use? Maybe it'll just be well known addresses, labels or variables in those routines.
