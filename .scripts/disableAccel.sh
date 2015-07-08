#!/bin/bash
# Disable mouse acceleration and set Razer DeathAdder 2013

sleep 5;

xset m 0 0

#xinput set-prop 8 'Device Accel Profile' -1
#xinput set-prop 8 'Device Accel Velocity Scaling' 1
xinput set-prop 9 'Device Accel Profile' -1
xinput set-prop 9 'Device Accel Velocity Scaling' 1

razercfg -r 18
