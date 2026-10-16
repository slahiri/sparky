---
title: Firmware
---

# Firmware

The firmware is a [PlatformIO](https://platformio.org) project in [firmware/](https://github.com/slahiri/sparky/blob/main/firmware). Right now it's a **hardware test** that checks every module:

- Animated eyes on the OLED that blink
- A beep on start-up and when you touch the head
- The LED flashes when you knock on the desk
- A live microphone level bar under the eyes

## Flash it

```bash
pip install platformio
cd firmware
pio run -t upload
pio device monitor
```

Use a USB data cable, not a charge-only one. If the upload doesn't start, hold **BOOT** on the ESP32-C3 while plugging in USB.

## Troubleshooting

- **"OLED NOT found":** check SDA/SCL (GPIO 8/9). Most 1.3" modules use the SH1106 driver; for an SSD1306, change the driver line at the top of `main.cpp`.
- **No sound:** check the amp has power and that BCLK/LRC/DIN go to GPIO 4/5/6.
- **Level bar stuck at zero:** check the mic's L/R pin is tied to GND and SD goes to GPIO 7.

The pin map is in [pins.h](https://github.com/slahiri/sparky/blob/main/firmware/include/pins.h).
