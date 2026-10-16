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

From the bottom up: **base → collar → rack → shell.** Inside the rack, the **face frame** (display and speaker) stands at the front, the **board** and the **middle plate** (motion sensor on top, amp underneath) slide in from the back, a LiPo can slide into either side bay, and the **lid** (mic and touch pad) drops in on top. Magnets join the base to the rack and the rack towers to the shell ceiling; the shell holds everything else in place.

## Get the files

- Source and STLs: [github.com/slahiri/sparky](https://github.com/slahiri/sparky)
- Ready-to-print STLs: [latest release](https://github.com/slahiri/sparky/releases/latest) (built automatically from the OpenSCAD source)
