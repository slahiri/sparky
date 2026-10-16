# Module interface (for remixers)

Any part that keeps these dimensions works with the rest of Sparky. All values live in [config.scad](https://github.com/slahiri/sparky/blob/main/cad/config.scad); the origin is the centre of the footprint on the table, with the screen facing −Y.

| Interface | Value |
|---|---|
| Footprint | 56 × 52 mm, R8 vertical corners |
| Battery base height | 12 mm (deck top) |
| Collar | 4 mm band + 2 mm locating ridge, 4 pin holes |
| Shell | bottom at Z 16, top at Z 70, 2 mm wall |
| Rack | 47.2 × 43.2 mm (R3.8 corners), Z 12 to 62 |
| Crown | 46 × 40.6 mm, Z 62 to 66, slides in from +Y on dovetails at X ±20.1 |
| Magnets | 6 × 3 mm, pockets 6.2 × 3.2 mm, all N faces up |
| Base ↔ rack magnets | (±21, −14), (±21, 16) |
| Crown ↔ shell magnets | (±17, −15), (±17, 17) at Z 66 |
| Lid ↔ base magnets | (±21, ±19) |
| Collar pins | (±25.9, 0), (0, ±23.9), 1.75 mm filament |

## Designing your own shell

Keep the inside of the classic shell (the space the rack needs, the 4 ceiling magnet pads and the bottom rim on the collar ridge) and keep the openings lined up: screen window, LED hole, mic pinhole, USB, switch and speaker grille. Everything outside that is yours to change: ears, a dome, a TV bezel, an antenna.
