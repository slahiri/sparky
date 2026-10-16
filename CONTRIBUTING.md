# Contributing to Sparky

Thanks for helping! Prints, photos, measurements and remixes are all welcome.

## Ways to help

- **Printed one?** Open a "Build report" issue with photos, your printer, filament and anything that didn't fit.
- **Measured a part?** Real dimensions for the modules in `cad/config.scad` are the most useful contribution right now.
- **New shell or module?** Keep the interface in `docs/interface.md` so it stays swappable.
- **Firmware:** keep pins in `firmware/include/pins.h` and make sure `pio run` builds.

## Workflow

1. Fork the repo and create a branch.
2. Edit the OpenSCAD source in `cad/`, never the STLs directly.
3. Run `./scripts/export_stl.sh` to regenerate `stl/` and commit both.
4. For firmware changes, run `pio run` in `firmware/`.
5. Open a pull request describing what changed and how you tested it (printed? flashed?).

By contributing you agree that your work is released under the project's licenses (see `LICENSE.md`).
