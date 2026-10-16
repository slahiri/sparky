---
title: Wiring
---

# Wiring

![Wiring diagram](images/wiring.svg)

| Module | Module pin | ESP32-C3 SuperMini |
|---|---|---|
| 1.3" OLED | SDA / SCL / VCC / GND | GPIO 8 / GPIO 9 / 3V3 / GND |
| MAX98357A | BCLK / LRC / DIN | GPIO 4 / GPIO 5 / GPIO 6 |
| MAX98357A | VIN / GND | 5V on USB, or the expansion board's 3.7 V rail on battery / GND |
| INMP441 | SCK / WS / SD | GPIO 4 / GPIO 5 / GPIO 7 |
| INMP441 | L/R / VDD / GND | GND / 3V3 / GND |
| Speaker | + / − | amp + / amp − |
| TTP223 | OUT / VCC / GND | GPIO 3 / 3V3 / GND |
| SW420 | DO / VCC / GND | GPIO 10 / 3V3 / GND |
| LED | anode → 220 Ω | GPIO 1 (cathode to GND) |
| Slide switch | in series with battery + | between LiPo + and the board |

Notes:

- GPIO 4 and GPIO 5 each go to **both** the amp and the mic.
- Never put 5 V on the INMP441.
- Leave the MAX98357A `SD` and `GAIN` pins unconnected (always on, 9 dB).
- Free pins: GPIO 0, 20, 21. Don't load GPIO 2 (boot strap).
- The pin map lives in [`firmware/include/pins.h`](https://github.com/slahiri/sparky/blob/main/firmware/include/pins.h).
