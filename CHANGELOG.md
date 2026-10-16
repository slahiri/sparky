# Changelog

## Unreleased

Slide-in, solderless redesign (v0.2). Not yet test-printed.

- New layout: every board slides into its own groove and plugs together with Dupont wires. Wire it outside, then slide it in
- Five printed parts: shell, collar, rack, face frame, front plate. The dovetail crown, the battery base and its lid are gone
- Rack, one print: solid bottom (no separate base), floor rails for the ESP32 board, a fixed middle plate with grooves for the MPU-6050 and the amp side by side, and a fixed top that holds the round INMP441 mic and the TTP223 touch pad over openings so their wires come up from below. The plate and the top stop 6 mm short of the open back: that gap is the wire channel. Only the boards slide
- Room for a LiPo 503040 along each side wall, slid in from the back
- **Face frame**: display groove and a speaker pocket; two posts on the rack floor stop the speaker from behind
- **Front plate**: display window and speaker grille, presses onto the face frame with 4 round pegs, pull notches on both sides
- 8 magnets (4 pairs, rack towers ↔ shell ceiling)
- Bigger body: 64.4 × 56.6 × 76 mm. Shell is R8 outside and R6 inside so the wall stays 2 mm at the corners
- Electronics: SW420, status LED and power switch removed; MPU-6050 added (I²C 0x68, INT on GPIO 10). No screws
- Every part prints without supports, in the orientation it's exported in
- New checks: `scripts/check_fit.sh` (no overlaps, every part on the bed) and `scripts/overhangs.py`
- Firmware test: shake / tap shows surprised eyes; LED and knock test removed
- New renders, explode GIF and wiring diagram

## v0.1.0 - 2026-10-16

First public draft.

- Parametric OpenSCAD source: outer shell, interface collar, reinforced inner rack, battery base and lid
- Magnetic snap joints (12 pairs of 6 × 3 mm magnets) and filament locating pins
- CI pipeline that builds every STL and preview render from the OpenSCAD source, and publishes releases on version tags
- PlatformIO hardware-test firmware for the ESP32-C3 SuperMini
- BOM, wiring diagram and build guide

Not yet test-printed; part sizes are estimates.
