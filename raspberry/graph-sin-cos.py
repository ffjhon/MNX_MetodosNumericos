#import upip
#upip.install('micropython-ili9341')

import math
import utime
from machine import Pin, SPI
import ILI9341  # Asume que tienes la librería ILI9341 instalada (puede variar según tu plataforma)

# Configuración del hardware para el display TFT ILI9341
spi = SPI(1, baudrate=10000000, polarity=0, phase=0)  # Configura el SPI según tu placa
tft_cs = Pin(15, Pin.OUT)  # Pin de chip select (puede cambiar según tu hardware)
tft_rst = Pin(4, Pin.OUT)  # Pin de reset (puede cambiar según tu hardware)
tft_dc = Pin(2, Pin.OUT)   # Pin de comando/datos (puede cambiar según tu hardware)

# Inicializa la pantalla ILI9341
lcd = ILI9341.ILI9341(spi, cs=tft_cs, rst=tft_rst, dc=tft_dc, width=240, height=320)

# Limpia la pantalla y muestra
lcd.fill(0)  # Rellenar toda la pantalla de negro
lcd.show()

# Definir colores
GRAY = lcd.color(80, 80, 80)
RED = lcd.color(255, 0, 0)
GREEN = lcd.color(0, 255, 0)

# Ajuste de la escala de la función (factor de conversión)
width = lcd.width()
factor = 361 / width

# Dibujar la línea base
lcd.hline(0, 40, 160, GRAY)    
lcd.show()

# Graficar la función seno en color rojo
for x in range(0, width):
    y = int((math.sin(math.radians(x * factor))) * -30) + 40  # Escalar la función seno
    lcd.pixel(x, y, RED)  # Dibujar un pixel rojo
lcd.text("Sine", 5, 65, RED)  # Texto en rojo
lcd.show()

# Pausar por 1 segundo
utime.sleep(1)

# Limpiar pantalla antes de graficar coseno
lcd.fill(0)  # Limpiar la pantalla
lcd.show()

# Graficar la función coseno en color verde
for x in range(0, width):
    y = int((math.cos(math.radians(x * factor))) * -30) + 40  # Escalar la función coseno
    lcd.pixel(x, y, GREEN)  # Dibujar un pixel verde
lcd.text("Cosine", 60, 10, GREEN)  # Texto en verde
lcd.show()

# Pausar por 5 segundos antes de terminar
utime.sleep(5)
