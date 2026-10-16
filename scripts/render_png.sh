#!/usr/bin/env bash
# Render preview images of the assembly and every part to renders/.
# Usage: scripts/render_png.sh [outdir]   (needs a display; use xvfb-run on CI)
set -euo pipefail
cd "$(dirname "$0")/.."
out="${1:-renders}"
mkdir -p "$out"
cam_iso="--camera=0,0,0,62,0,35,0"
cam_part="--camera=0,0,0,60,0,215,0"
common=(-q --render --autocenter --viewall --colorscheme=Tomorrow)
openscad "${common[@]}" --imgsize=1200,900  $cam_iso -o "$out/sparky_assembled.png" cad/sparky.scad
openscad "${common[@]}" --imgsize=1200,1000 $cam_iso -D explode=40 -o "$out/sparky_exploded.png" cad/sparky.scad
for p in shell collar rack face front; do
  openscad "${common[@]}" --imgsize=800,640 $cam_part -D "part=\"$p\"" -o "$out/part_$p.png" cad/sparky.scad
done
echo "Renders are in $out/"
