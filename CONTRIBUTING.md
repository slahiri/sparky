# Contributing to Sparky

Thanks for helping! Prints, photos, measurements and remixes are all welcome.

## Ways to help

- **Printed one?** Open a "Build report" issue with photos, your printer, filament and anything that didn't fit.
- **Measured a part?** Real dimensions for the modules in `cad/config.scad` are the most useful contribution right now.
- **New shell or module?** Keep the interface in `docs/interface.md` so it stays swappable.
- **Firmware:** keep pins in `firmware/include/pins.h` and make sure `pio run` builds.

## Workflow

1. Fork the repo and create a branch.
2. Edit the OpenSCAD source in `cad/`. **Don't commit STLs**: CI builds them.
3. Optionally check locally with `./scripts/export_stl.sh` and `./scripts/render_png.sh`.
4. For firmware changes, run `pio run` in `firmware/`.
5. Open a pull request against `main` describing what changed and how you tested it (printed? flashed?).
6. CI must pass (**Build STLs** and **Build firmware**) and a maintainer reviews before merge. The PR's CAD run has the STLs and renders as artifacts, so reviewers can check the geometry without building it.

`main` is protected: all changes go through pull requests.

By contributing you agree that your work is released under the project's licenses (see `LICENSE.md`).
