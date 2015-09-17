#!/bin/sh
# When exporting the gpio, if the following message shows up:
# 		sh: write error: Device or resource busy
# it means that the gpio is already exported
#
# Setting IO2 as output
#

echo "Configuring IO2 as output"
echo "Exporting gpio128"
echo 128 > /sys/class/gpio/export 		# IO2
echo "Exporting gpio250"
echo 250 > /sys/class/gpio/export 		# Output enable (high = output)
echo "Exporting gpio218"
echo 218 > /sys/class/gpio/export 		# Pull-up enable

echo "Configure I2C communication to A4 and A5"
echo "Exporting gpio28"
echo 28 > /sys/class/gpio/export
echo "Exporting gpio27"
echo 27 > /sys/class/gpio/export 
echo "Exporting gpio204"
echo 204 > /sys/class/gpio/export 
echo "Exporting gpio205"
echo 205 > /sys/class/gpio/export 
echo "Exporting gpio236"
echo 236 > /sys/class/gpio/export 
echo "Exporting gpio237"
echo 237 > /sys/class/gpio/export 
echo "Exporting gpio14"
echo 14 > /sys/class/gpio/export 
echo "Exporting gpio165"
echo 165 > /sys/class/gpio/export 
echo "Exporting gpio212"
echo 212 > /sys/class/gpio/export 
echo "Exporting gpio213"
echo 213 > /sys/class/gpio/export 
echo "Exporting gpio214"
echo 214 > /sys/class/gpio/export 

echo "Tri-State low before configure"
echo low > /sys/class/gpio/gpio214/direction # Tri-State (set it low before configure the rest, then set it high)

#I2C
echo low > /sys/class/gpio/gpio204/direction 
echo low > /sys/class/gpio/gpio205/direction 
echo in > /sys/class/gpio/gpio14/direction 
echo in > /sys/class/gpio/gpio165/direction 
echo low > /sys/class/gpio/gpio236/direction 
echo low > /sys/class/gpio/gpio237/direction 
echo out > /sys/class/gpio/gpio212/direction 
echo out > /sys/class/gpio/gpio213/direction 
echo mode1 > /sys/kernel/debug/gpio_debug/gpio28/current_pinmux 
echo mode1 > /sys/kernel/debug/gpio_debug/gpio27/current_pinmux 


#OnBoardLed as Output
echo high > /sys/class/gpio/gpio250/direction	# Set gpio128 as output (Output enable = high)
echo "Output direction enabled"
echo mode0 > /sys/kernel/debug/gpio_debug/gpio128/current_pinmux # Set the pin as gpio mode
echo "Mode0 (gpio mode) set"
echo out > /sys/class/gpio/gpio128/direction 	# Set the gpio pin as output
echo "IO2 set as output"

echo high > /sys/class/gpio/gpio214/direction
echo "Tri-state buffer enabled"
echo "Configuration completed"
echo ""
echo "To write a value (low or high) use the follow commands:"
echo "For write a high value:"
echo "echo 1 > /sys/class/gpio/gpio128/value"
echo "For write a low value:"
echo "echo 0 > /sys/class/gpio/gpio128/value"
echo ""
echo "After writting the value, it can be checked with the follow command:"
echo "cat /sys/class/gpio/gpio128/value"
echo ""
# To write high: echo 1 > /sys/class/gpio/gpio128/value
# To write low:  echo 0 > /sys/class/gpio/gpio128/value
