# Miscellaneous Challanges

These challenges are for basic CTF skills, hacker trivia or cool challenges that don't fit anywhere else.

#Challenge 1: Enter Pass 1

These are meant to kind of mess with the user. The first binary will ask for a password for the flag
The flag and password are in the binary, but users have only 10 seconds to enter the password it to decode the flag. They could do it themselves, but that's a pain, lol.

###password: 69nice
###flag: FRECKLESCON22{FrecklesIsAgoodBoy}

#Challenge 2: Enter Pass 2
In the second challenge, the password for the flag is 69 (nice) characters long, and the users have only 2 seconds to enter it.
Needless to say they'll need to be clever.

###password: 69 of the character 'a'
###flag: FRECKLESCON22{FrecklesIsNotAGoodBoy?Blasphemy}


#Light socket stuff

#Challenge 1: socket_chal1.c

This challenge taunts the user with a joke/hint, but then starts a listener for telnet on port 23.
Once the user connects it sends them the flag back through that connection. Simple, but gets them to use netstat, or just look at the code to see what 
is going on.

##flag: FRECKLESCON22{telnet,get it? lol}

#Challenge 2: socket_chal2.c

This is a similar challenge, only the port is randomly chosen between ports 30,000 and 40,000, forcing the user to use netsat to see which one is open. However, there is no hint this time to say what was going on.

##flag: FRECKLESCON22{coming up with witty jokes is hard, ok!?}






 
