# Sparky

A modular, magnetic ESP32-C3 desk buddy with an animated OLED face, a microphone, a speaker, touch and knock sensing, and an optional battery.

![Sparky assembled](images/sparky_assembled.png)

> **v0.1 prototype.** Part sizes are estimates and nothing has been test-printed yet. Measure your parts and adjust [config.scad](https://github.com/slahiri/sparky/blob/main/cad/config.scad) first.

## Build guide

1. [Bill of materials](bom.md)
2. [Printing](printing.md)
3. [Wiring](wiring.md)
4. [Assembly](assembly.md)
5. [Firmware](firmware.md)
6. [Module interface (for remixers)](interface.md)

## How it fits together

![Exploded view](images/sparky_exploded.png)

From the bottom up: **battery lid → battery base → interface collar → inner rack → outer shell.** Magnets join the lid to the base, the base to the rack, and the rack crown to the shell ceiling. The collar is clamped between the base and the shell.

## Get the files

- Source and STLs: [github.com/slahiri/sparky](https://github.com/slahiri/sparky)
- Ready-to-print STLs: [stl/](https://github.com/slahiri/sparky/tree/main/stl)
