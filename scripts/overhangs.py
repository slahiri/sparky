#!/usr/bin/env python3
"""Lists down-facing surfaces steeper than 45 deg (above the bed) in print-oriented STLs.
Flat ones are bridges or overhangs; check each is supported at both ends.
Usage: scripts/overhangs.py stl/sparky_*.stl"""
import math, re, sys
from collections import defaultdict

for path in sys.argv[1:]:
    v = [tuple(map(float, m)) for m in re.findall(r"vertex\s+(\S+)\s+(\S+)\s+(\S+)", open(path).read())]
    groups = defaultdict(lambda: [0.0, [1e9, -1e9, 1e9, -1e9]])
    for i in range(0, len(v) - 2, 3):
        a, b, c = v[i], v[i + 1], v[i + 2]
        u = [b[k] - a[k] for k in range(3)]; w = [c[k] - a[k] for k in range(3)]
        n = [u[1]*w[2] - u[2]*w[1], u[2]*w[0] - u[0]*w[2], u[0]*w[1] - u[1]*w[0]]
        area = math.sqrt(sum(x*x for x in n)) / 2
        if area < 1e-6: continue
        nz = n[2] / (2 * area)
        zmin = min(a[2], b[2], c[2])
        if nz < -0.72 and zmin > 0.2:
            g = groups[round(zmin * 2) / 2]
            g[0] += area
            for p in (a, b, c):
                g[1][0] = min(g[1][0], p[0]); g[1][1] = max(g[1][1], p[0])
                g[1][2] = min(g[1][2], p[1]); g[1][3] = max(g[1][3], p[1])
    print(f"== {path}")
    for z in sorted(groups):
        area, (x0, x1, y0, y1) = groups[z]
        if area > 0.5:
            print(f"  z {z:6.1f}  {area:7.1f} mm2  x {x0:6.1f}..{x1:6.1f}  y {y0:6.1f}..{y1:6.1f}")
