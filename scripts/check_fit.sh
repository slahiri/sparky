#!/usr/bin/env bash
# Checks that no two printed parts overlap when assembled, and that every
# exported STL sits on the bed (lowest point at Z = 0).
# Usage: scripts/check_fit.sh   (run scripts/export_stl.sh first)
set -euo pipefail
cd "$(dirname "$0")/.."
parts=(shell collar base rack face lid)
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

for p in "${parts[@]}"; do
  openscad -q -D "part=\"fit_$p\"" -o "$tmp/$p.stl" cad/sparky.scad
done

fail=0
for ((i = 0; i < ${#parts[@]}; i++)); do
  for ((j = i + 1; j < ${#parts[@]}; j++)); do
    a=${parts[$i]} b=${parts[$j]}
    printf 'intersection() { import("%s"); import("%s"); }\n' "$tmp/$a.stl" "$tmp/$b.stl" > "$tmp/x.scad"
    openscad -q -o "$tmp/x.stl" "$tmp/x.scad" 2>/dev/null || true
    vol=$(python3 scripts/stl_volume.py "$tmp/x.stl")
    if awk -v v="$vol" 'BEGIN { exit !(v > 0.5) }'; then
      echo "OVERLAP: $a x $b ($vol mm3)"
      fail=1
    fi
  done
done

for p in "${parts[@]}"; do
  zmin=$(awk '/vertex/ { if (min == "" || $4 < min) min = $4 } END { print min }' "stl/sparky_$p.stl")
  awk -v z="$zmin" -v p="$p" 'BEGIN { if (z < -0.01 || z > 0.01) { print "NOT ON BED: " p " (z min " z ")"; exit 1 } }' || fail=1
done

[ "$fail" = 0 ] && echo "Fit check passed: no overlaps, every part on the bed."
exit "$fail"
