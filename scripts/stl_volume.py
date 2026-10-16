#!/usr/bin/env python3
"""Prints the enclosed volume (mm3) of an ASCII STL, or 0 if it is missing or empty."""
import re, sys

def volume(path):
    try:
        text = open(path).read()
    except OSError:
        return 0.0
    v = [tuple(map(float, m)) for m in re.findall(r"vertex\s+(\S+)\s+(\S+)\s+(\S+)", text)]
    total = 0.0
    for i in range(0, len(v) - 2, 3):
        (ax, ay, az), (bx, by, bz), (cx, cy, cz) = v[i], v[i + 1], v[i + 2]
        total += (ax * (by * cz - bz * cy) - ay * (bx * cz - bz * cx) + az * (bx * cy - by * cx)) / 6
    return abs(total)

print(f"{volume(sys.argv[1]):.2f}")
