// Sparky pin map for the ESP32-C3 SuperMini on its expansion board.
// Keep in sync with hardware/wiring.md.
#pragma once

// 1.3" OLED (SH1106 / SSD1306, I2C 0x3C)
#define PIN_OLED_SDA   8
#define PIN_OLED_SCL   9

// I2S audio: MAX98357A amplifier and INMP441 mic share BCLK and WS
#define PIN_I2S_BCLK   4   // amp BCLK + mic SCK
#define PIN_I2S_WS     5   // amp LRC  + mic WS
#define PIN_AMP_DIN    6   // ESP32 -> amp
#define PIN_MIC_SD     7   // mic -> ESP32 (mic L/R tied to GND)

// Inputs and outputs
#define PIN_TOUCH      3   // TTP223 OUT, HIGH while touched
#define PIN_VIBRATION 10   // SW420 DO, changes level on a knock
#define PIN_LED        1   // status LED via 220 ohm to GND

// Free: GPIO 0, 20, 21. Avoid loading GPIO 2 (boot strap).
