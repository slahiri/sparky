# Module interface (for remixers)

Any part that keeps these dimensions works with the rest of Sparky. All values live in [config.scad](https://github.com/slahiri/sparky/blob/main/cad/config.scad); the origin is the centre line of the body on the table, with the screen facing −Y.

| Interface | Value |
|---|---|
| Footprint | 64.4 × 56.6 mm (Y −30 to 26.6), R8 corners |
| Base | Z 0 to 7 (5 mm plate on 2 mm feet) |
| Collar | Z 7 to 11, 2 pin holes |
| Shell | Z 11 to 76, 2 mm wall, R8 outside, R6 inside |
| Rack | 59.6 × 49.2 mm (Y −27.6 to 21.6), 45° front corners, R3.5 back corners, Z 7 to 72.4 |
| Lid | 34 mm wide, between the towers, Z 68.4 to 72.4 |
| Middle plate | Z 43 to 46, slides on ledges on the walls |
| Magnets | 6 × 3 mm, pockets 6.2 × 3.2 mm, all N faces up |
| Base ↔ rack magnets | (±24, −15), (±24, 16) |
| Rack ↔ shell magnets | (±23, −15), (±23, 17) at Z 72.4 |
| Collar pins | (±15, 24.25), 1.75 mm filament |
| Face frame pins | (±24, −23.5), 1.75 mm filament |

## Designing your own shell

Keep the inside of the classic shell (the space the rack needs and the 4 ceiling magnet bosses) and keep the openings lined up: display window, speaker grille, USB-C at the back and the mic pinhole on top. Everything outside that is yours to change: ears, a dome, a TV bezel, an antenna.
