#!/bin/bash

screenWidth="1366"
screenHeight="768"
tvWidth="1920"
tvHeight="1080"

scaleWidth=$((10000 * screenWidth / tvWidth))
scaleHeight=$((10000 * screenHeight / tvHeight))

xrandr --output HDMI1 --auto --same-as eDP1 --scale 0.${scaleWidth}x0.${scaleHeight}
