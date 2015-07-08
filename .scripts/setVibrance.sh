#!/bin/bash
# From: https://www.reddit.com/r/GlobalOffensive/comments/30cgo3/linux_digital_vibrance_script_for_nvidia_users/

# -1024 = 0   %
#    0  = 50  %
#  1023 = 100 %

# Set Digital Vibrance
min="-1024"
max="1023"
def="0"
val="$1"

if [[ "$val" -lt 50 ]]; then
    onePercent=$(((max - min)/100))
    vibrance=$((min + val*onePercent))
elif [[ "$val" -gt 50 ]]; then
    onePercent=$(((max - def)/50))
    vibrance=$((def + (val-50)*onePercent))
else
    vibrance="0"
fi

echo "$onePercent"
echo "$vibrance"

#nvidia-settings -a "[gpu:0]/DigitalVibrance[DFP-0]=$vibrance" > /dev/null

echo "Digital Vibrance: ${val}%"
