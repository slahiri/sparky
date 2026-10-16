# Changelog

## Unreleased

Slide-in, solderless redesign (v0.2). Not yet test-printed.

- New layout: every board slides into its own groove and plugs together with Dupont wires. Wire it outside, then slide it in
- New parts: **face frame** (display groove + speaker behind a front grille), **middle plate** (MPU-6050 on top, amp underneath, corner wire holes) and a drop-in **lid** (round INMP441 mic pocket + TTP223 touch pad). The dovetail crown and the battery lid are gone
- Rack: open back, board rails on the floor, wall ledges for the plate, a LiPo 503040 bay on each side, and two top towers that carry the shell magnets
- Base is now a simple 5 mm plate on feet; the battery moved into the side bays
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
