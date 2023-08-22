# ParkingMeter
Designed (coded, simulated, and implemented) a parking meter much like the ones around Austin. Program is able to simulate coins being added and shows the appropriate time remaining. Also, it flashs slowly when less than 200 seconds are remaining and flash quickly when time has expired.
Used finite state machine that simulates the operation of a traffic meter. The buttons on the board represent different coin denominations and the seven segment LED display outputs the total amount of seconds remaining before the meter expires.
Configuration:
Button U Add 10 seconds
Button L Add 180 seconds
Button R Add 200 seconds
Button D Add 550 seconds
Switch 0 Reset time to 10 seconds
Switch 1 Reset time to 205 seconds

As soon as a button is pushed, the time is added immediately. 
