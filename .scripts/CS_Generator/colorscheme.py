#!/usr/bin/python
# -*- coding:Utf-8 -*-

# Original: https://gist.github.com/radiosilence/3946121#file-gistfile1-py-L68
# Dependencies (for both this script and colorz.py): python-yaml python-pil

import sys
import colorsys
from colorz import colorz

WALLPAPER = sys.argv[1]
COLORS = '/home/kevin/.colors/WallpaperGenerated.colors'

cols = """
! Default
*background:  #0E0E0E
*foreground:  #FFFFFF
*cursorColor: #FFFFFF

! URxvt
URxvt.background: [85]#0E0E0E

! Colors

"""

def normalize(hexv, minv=128, maxv=256):
    hexv = hexv[1:]
    r, g, b = (
        int(hexv[0:2], 16) / 256.0,
        int(hexv[2:4], 16) / 256.0,
        int(hexv[4:6], 16) / 256.0,
    )
    h, s, v = colorsys.rgb_to_hsv(r, g, b)
    minv = minv / 256.0
    maxv = maxv / 256.0
    if v < minv:
        v = minv
    if v > maxv:
        v = maxv
    r, g, b = colorsys.hsv_to_rgb(h, s, v)
    return '#{:02x}{:02x}{:02x}'.format(int(r * 256), int(g * 256), int(b * 256))

if __name__ == '__main__':
    #if len(sys.argv) == 1:
    #    n = 16
    #else:
    #    n = int(sys.argv[1])
    # Always use 16 colors
    n = 16

    i = 0
    for c in colorz(WALLPAPER, n=n):
        # if i == 8:
        #     i += 1
        if i == 0:
            c = normalize(c, minv=0, maxv=32)
        elif i == 8:
            c = normalize(c, minv=128, maxv=192)
        elif i < 8:
            c = normalize(c, minv=160, maxv=224)
        else:
            c = normalize(c, minv=200, maxv=256)
        cols += """*color{}: {}\n""".format(i, c)
        i += 1

    with open(COLORS, 'w') as f:
        f.write(cols)

