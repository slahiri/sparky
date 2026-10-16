// Sparky pin map for the ESP32-C3 SuperMini on its expansion board.
// Keep in sync with docs/wiring.md.
#pragma once

// I2C bus: 1.3" OLED (SH1106 / SSD1306, 0x3C) and MPU-6050 (0x68)
#define PIN_I2C_SDA    8
#define PIN_I2C_SCL    9
#define OLED_ADDR      0x3C
#define MPU_ADDR       0x68

// I2S audio: MAX98357A amplifier and INMP441 mic share BCLK and WS
#define PIN_I2S_BCLK   4   // amp BCLK + mic SCK
#define PIN_I2S_WS     5   // amp LRC  + mic WS
#define PIN_AMP_DIN    6   // ESP32 -> amp
#define PIN_MIC_SD     7   // mic -> ESP32 (mic L/R tied to GND)

// Inputs
#define PIN_TOUCH      3   // TTP223 OUT, HIGH while touched
#define PIN_MPU_INT   10   // MPU-6050 INT (motion interrupt, optional)

// Free: GPIO 0, 1, 20, 21. Avoid loading GPIO 2 (boot strap).
