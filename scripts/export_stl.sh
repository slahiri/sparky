#!/usr/bin/env bash
# Export every printable part to stl/. Usage: scripts/export_stl.sh
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p stl
for p in shell collar rack base lid; do
  echo "Exporting $p..."
  openscad -q -D "part=\"$p\"" -o "stl/sparky_$p.stl" cad/sparky.scad
done
echo "Done. STLs are in stl/"
