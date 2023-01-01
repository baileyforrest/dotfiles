#!/bin/bash

SENSITIVITY=1.0

xinput --set-prop "pointer:Logitech MX Vertical" "Coordinate Transformation Matrix" $SENSITIVITY 0 0 0 $SENSITIVITY 0 0 0 1
xinput --set-prop "pointer:Logitech MX Vertical" "libinput Accel Profile Enabled" 0, 1
