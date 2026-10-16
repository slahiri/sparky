#!/usr/bin/env bash
# Render an animated GIF of Sparky exploding into its modules and back.
# Usage: scripts/render_gif.sh [output.gif]   (needs openscad + ImageMagick)
set -euo pipefail
cd "$(dirname "$0")/.."
out="${1:-docs/images/sparky_explode.gif}"
frames="$(mktemp -d)"
steps=18                                  # frames per direction
python3 - "$steps" > "$frames/plan.txt" <<'PY'
import math, sys
n = int(sys.argv[1])
ts = [0.0] * 6                                            # hold assembled
ts += [i / n for i in range(1, n + 1)]                    # blast apart
ts += [1.0] * 8                                           # hold exploded
ts += [1 - i / n for i in range(1, n + 1)]                # snap back
for i, t in enumerate(ts):
    e = (1 - math.cos(math.pi * t)) / 2                   # ease in-out
    print(i, f"{45 * e:.2f}", f"{35 + 62 * e:.1f}", f"{300 + 360 * e:.0f}", f"{35 + 20 * e:.1f}")
PY
while read -r i explode tz dist rz; do
  openscad -q --render --imgsize=640,640 --colorscheme=Tomorrow --projection=p \
    --camera=0,0,"$tz",62,0,"$rz","$dist" -D "explode=$explode" \
    -o "$frames/$(printf '%03d' "$i").png" cad/sparky.scad
done < "$frames/plan.txt"
magick -delay 6 -loop 0 "$frames"/[0-9]*.png -resize 480x480 -layers Optimize -colors 96 "$out"
rm -rf "$frames"
echo "Wrote $out"
