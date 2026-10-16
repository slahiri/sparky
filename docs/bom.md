# Bill of materials

The full list with example links is in [hardware/bom.csv](https://github.com/slahiri/sparky/blob/main/hardware/bom.csv).

| Qty | Part | Notes |
|---|---|---|
| 1 | ESP32-C3 SuperMini | Main controller |
| 1 | ESP32-C3 SuperMini expansion board | LiPo charging and pin breakout; every module plugs into it |
| 1 | 1.3" I²C OLED (SH1106 or SSD1306) | The face |
| 1 | GY-521 MPU-6050 | Shake, tilt and tap sensing |
| 1 | MAX98357A I²S amplifier | Drives the speaker |
| 1 | INMP441 I²S microphone | The round board |
| 1 | 2040 speaker, 4 Ω 2 W | 20 × 40 mm |
| 1 | TTP223 touch module | Under the shell top |
| 1 | LiPo 503040, about 600 mAh | Optional; fits either side bay. Check plug and polarity |
| 16 | 6 × 3 mm neodymium magnets | 8 pairs |
| 4 | 1.75 mm filament, about 5 mm long | Locating pins for the collar and face frame |
| 4 | Dupont Y-splitters | SDA, SCL, BCLK, WS are shared |
| ~25 | Female–female Dupont wires | 10–20 cm |

No screws. The MPU-6050, amp and mic usually ship with loose pin headers: solder those once, and everything after that plugs together. You'll also need PLA, super glue for the magnets and a marker for the magnet poles.
