# Printing

Download the STLs from the [latest release](https://github.com/slahiri/sparky/releases/latest). CI builds them from the OpenSCAD source, already placed in their print orientation. **No part needs supports.**

| Part | File | Orientation | Notes |
|---|---|---|---|
| Outer shell | `sparky_shell.stl` | Upside down, on its top | The display window top is a 31 mm bridge. The rounded top edge overhangs a little for the first ~2 mm: print the first layers slowly |
| Interface collar | `sparky_collar.stl` | Flat | Accent colour looks great |
| Rack | `sparky_rack.stl` | Upright on its bottom | Structural: see settings below. The middle plate (55 mm) and the top (40 mm) are bridges: turn on bridge cooling |
| Face frame | `sparky_face.stl` | Face down | Every shelf and stop grows straight off the bed |
| Front plate | `sparky_front.stl` | Face down, pegs up | If the pegs are too tight or loose, change `peg_hole` in config.scad |

![The rack](images/part_rack.png)

## Recommended PLA settings

| Setting | Shell, collar, front plate | Rack, face frame |
|---|---|---|
| Layer height | 0.2 mm | 0.2 mm |
| Walls | 3 | 5 |
| Infill | 15 % gyroid | 30 % gyroid |
| Supports | none | none |

For a quick fit test of the rack, 2 walls, 3 top / 2 bottom layers and 5 % infill use about 25 g of PLA.

Keep PLA parts out of hot cars and direct sun: PLA softens around 55 °C.

## Before the full print

Print a test of one magnet pocket (6.2 × 3.2 mm). If the magnet is loose, lower `mag_d` in [config.scad](https://github.com/slahiri/sparky/blob/main/cad/config.scad); if it won't go in, raise it. Measure your display, board, MPU-6050, amp, mic and touch pad too, and set their sizes in the "Components" section. Then regenerate the STLs with `scripts/export_stl.sh`, or push your change and download them from the CI run.

To check a change, run `scripts/check_fit.sh` (no two parts overlap, every STL sits on the bed) and `scripts/overhangs.py stl/*.stl` (lists every down-facing surface steeper than 45°).
