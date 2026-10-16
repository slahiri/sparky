# Sparky

A modular, magnetic ESP32-C3 desk buddy with an animated OLED face, a microphone, a speaker, touch and motion sensing, and an optional battery. Everything slides in and plugs together: no screws, no soldered wiring.

![Sparky snapping apart into its modules](images/sparky_explode.gif)

> **v0.2 prototype.** Part sizes are estimates and the v0.2 parts have not been test-printed yet. Measure your parts and adjust [config.scad](https://github.com/slahiri/sparky/blob/main/cad/config.scad) first.

## Build guide

1. [Bill of materials](bom.md)
2. [Printing](printing.md)
3. [Wiring](wiring.md)
4. [Assembly](assembly.md)
5. [Firmware](firmware.md)
6. [Module interface (for remixers)](interface.md)

## How it fits together

![Exploded view](images/sparky_exploded.png)

**Rack → collar → shell**, with the **face frame** and its **front plate** at the front. The rack is one print: Sparky stands on its solid bottom, the ESP32 board slides in along the floor, the **MPU-6050** and **amp** slide into grooves on the fixed middle plate, a LiPo can slide in along either side wall, and the mic and touch pad sit on the fixed top. All wiring drops down a channel at the back. Four magnet pairs join the rack towers to the shell ceiling; the shell holds everything else in place.

## Get the files

- Source and STLs: [github.com/slahiri/sparky](https://github.com/slahiri/sparky)
- Ready-to-print STLs: [latest release](https://github.com/slahiri/sparky/releases/latest) (built automatically from the OpenSCAD source)
