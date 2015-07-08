#!/bin/bash
# From: https://www.reddit.com/r/GlobalOffensive/comments/30cgo3/linux_digital_vibrance_script_for_nvidia_users/

# -1024 = 0   %
#    0  = 50  %
#  1023 = 100 %

if [[ `nvidia-settings -q '[gpu:0]/DigitalVibrance[DFP-0]' | grep 'Attribute.*410\.'` ]]; then
    nvidia-settings -a '[gpu:0]/DigitalVibrance[DFP-0]=0' > /dev/null
    echo "Digital Vibrance: 50%"
else 
    nvidia-settings -a '[gpu:0]/DigitalVibrance[DFP-0]=410' > /dev/null
    echo "Digital Vibrance: 70%"
fi
