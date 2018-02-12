Example configurations for Geeetech Prusa i3 Pro B with GT2560A+ are available in the official Marlin repo, both without any probe and with BLTouch/3DTouch. Furthermore, a custom configuration for `marvin` is available at branch `bugfix-1.1.x-i3PB-marvin` of `FreeJaus/Marlin`.

# Posibles mejoras (ToDo)

## Mejorar alargadores del BLTouch/3DTouch a la GT2560A+

¿Conector único del carro a la placa para llevar servo + bltouch + ventilador?

## Y carriage

### LM8UU clamps

Pieza(s) para sujetar la base a los rodamientos lineales de los ejes Y, en sustitución de las bridas.

### Sujección cristal-cama

- Pinza lateral (papeleria)
- Placa borosilicato 2-3mm (en lugar de 4mm)

## X carriage

### Layer fan/blower

- https://www.thingiverse.com/thing:2469333
- Ejemplo blower de capa + BLTouch/3DTouch: https://www.thingiverse.com/thing:1846913

### Bloque de aluminio para el muelle del extrusor

- https://es.aliexpress.com/item/3D-Printer-MK8-extruder-aluminum-block-DIY-kit-Makerbot-single-nozzle-extrusion-aluminum-block-Three-style/32519713521.html?spm=2114.13010608.0.0.MMXTJS
- http://www.geeetech.com/mk8-extruder-aluminum-feeder-kit-for-175mm3mm-filament-p-995.html?zenid=2k1nmg26rq3trvabcg0n80sg54

### Filament runout sensor

https://www.youtube.com/watch?v=7y0F1qbAlFw

### Bowden extruder

## Marlin

http://marlinfw.org/docs/configuration/configuration.html

### Joystick

- https://github.com/MarlinFirmware/Marlin/issues/2775
- https://github.com/MarlinFirmware/Marlin/pull/2803
- https://github.com/MarlinFirmware/Marlin/issues/2912

Among 16 available ADC pins, only five seem to be used in the GT2560A+: ADC0, ADC1, ADC8, ADC9, ADC10.

The most interesting pins to be used for a joystick are ADC2 and ADC3, 95 and 94 respectively. These are not shared with any other functionality, so no limitation is introduced.

### LCD

- Bootscreen
- Menu customization/customizer
- References:
  - https://github.com/MarlinFirmware/Marlin/pull/7832
  - https://www.youtube.com/watch?v=3fGHgzZqaGs
  - http://marlinfw.org/tools/u8glib/converter.html

### Fin de carrera y sensores mediante interrupciones

> Enable this feature if all enabled endstop pins are interrupt-capable. This will remove the need to poll the interrupt pins, saving many CPU cycles.

https://github.com/MarlinFirmware/Marlin/issues/5484

Endstop connectors in the GT2560A+ are connected to pins 58, 60, 72, 74, 76 and 78. None of these is interrupt-capable. However, there are ten PCINT pins available and unused: 65-69 and 82-86.

Therefore, up to eight bridges should be soldered to move those connections to interrupt-capable pins. Shall paths to original pins be cut, those could be reused.

### CH340 + NRF24L01+

- https://github.com/BastilleResearch/mousejack/issues/19
- https://github.com/insecurityofthings/uC_mousejack
- http://forum.arduino.cc/index.php?topic=410574.15

### Linear advance

http://marlinfw.org/docs/features/lin_advance.html

## Caja con ventilador de 120mm para la electrónica

- Con espacio para mantener los cables sobrantes separados de los disipadores, y así mejorar la ventilación.
- Interruptor para USB. O relé?

## Caja externa para la electrónica de control

- RaspberryPi
- Pantalla táctil

## Base/caja

"Plancha" como base, para evitar que los cables pasados por debajo de los ejes Y se "pisen" al mover la impresora.

- 5,50€ SNUDDA, Estante giratorio, madera maciza abedul: http://www.ikea.com/es/es/catalog/products/90074483/
- 8€/2 unidades ORRNÄS, Tirador, ac inox col acinox: http://www.ikea.com/es/es/catalog/products/70236151/
- €5/2 unidades STUBBARP Pata, negro-marrón:http://www.ikea.com/es/es/catalog/products/10293564/#/60293566
- 10€  LACK Mesa auxiliar, negro: http://www.ikea.com/es/es/catalog/products/20011413/#/20011408

## Acabado de las piezas

- http://www.geeetech.com/blog/2018/02/essential-tools-that-every-3d-printing-passionist-must-have/
- ¿Alcohol/acetona?

# Modificaciones/mejoras realizadas.

- Uno de los arcos para sujetar los rodamientos lineales del eje X no tenía roscados los orificios. Se han roscado con una terraja y se ha solicitado un recambio.
- Cambio del embellecedor del encoder (LCD) por uno más sencillo/compacto, y adición de un trozo de goma (cortado del sobrante de las correas) para limitar la profundidad.
- BLTouch/3DTouch:
  - 3DTouch auto leveling sensor-1: http://www.geeetech.com/wiki/images/6/61/3DTouch_auto_leveling_sensor-1.zip
  - Cable adaptador del conector del sensor al conector utilizado en la GT2560A+ para los fin de carrera.
  - Cable alargador para el conector del servo.
  - Configuración, prueba y calibrado:
    - http://www.geeetech.com/wiki/index.php/3DTouch_Auto_Leveling_Sensor
    - http://marlinfw.org/docs/configuration/probes.html
    - `M280 P0 S10`
    - MarlinFirmware/Marlin #7024 #6102 #5705 #5650 #2914
- Guías para filamento:
  - FilamentGuideArm0: https://www.thingiverse.com/thing:1915337
  - A6_Filament_Guide: https://www.thingiverse.com/thing:1980281
- Cortar tornillo carro derecho (tensor de la correa), para evitar que el motor del extrusor golpee y así ganar un centímetro de margen.
