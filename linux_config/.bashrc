# Colorize terminal prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# display all files in current directory in detailed mode
alias ll="ls -al --color"

# Use ctrl+l to clear terminal
bind -m vi-insert "\C-l":clear-screen

# Used to drive the car
# Takes 2 arguments: arg1=speed left wheels, arg2=speed of right wheels
function drive() {
	~/self_driving_car/spi/write $1,$2#
}

# Used to flash a C program to the Atmega328p
function flash() {
	# remove extension from arg
	filename= $(echo $@ | cut -d '.' -f 1)

	# create object and hex files
	avr-gcc -std =c11 -mmcu =atmega328 -O -o "$filename.o" $@
	avr-objcopy -O ihex $filename.o $filename.hex
	
	# flash hex file to atmega
	sudo avrdude -c usbtiny -p m328 -U flash:w: $filename.hex
	
	# remove object and hex files to keep dir clean
	rm $filename.o $filename.hex
}
