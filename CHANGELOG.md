# Changelog

## Unreleased

- Removable crown: the rack's top is now a separate part that slides in from the back on dovetail rails, so the rack can be wired from above
- Shell magnets moved into the crown at (±17, −15) and (±17, 17); crown is 4 mm thick
- Fixed: rack corners clashed with the collar's rounded opening (rack now has R3.8 corners)
- Speaker cradle lowered to clear the new rail bars

## v0.1.0 - 2026-10-16

First public draft.

- Parametric OpenSCAD source: outer shell, interface collar, reinforced inner rack, battery base and lid
- Magnetic snap joints (12 pairs of 6 × 3 mm magnets) and filament locating pins
- CI pipeline that builds every STL and preview render from the OpenSCAD source, and publishes releases on version tags
- PlatformIO hardware-test firmware for the ESP32-C3 SuperMini
- BOM, wiring diagram and build guide

Not yet test-printed; part sizes are estimates.
