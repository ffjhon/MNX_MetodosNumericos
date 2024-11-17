# Raspberrypi Pico W
import machine
import time

led=machine.Pin("WL_GPIO0", machine.Pin.OUT) #WL_GPIOO Correccion del pin interno de la tarjeta R-pi Pico W

while True:
    led.value(True) 	#turn on the LED
    time.sleep(1)   	#wait for one second
    led.value(False)  	#turn off the LED
    time.sleep(1)   	#wait for one second