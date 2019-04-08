#!/bin/sh


for id in $(xinput --list | \
        grep 'Razer Razer DeathAdder Elite' | \
        perl -ne 'while (m/id=(\d+)/g){print "$1\n";}'); do
    xinput set-prop $id "Coordinate Transformation Matrix" \
        1.5, 0.0, 0.0, 0.0, 1.5, 0.0, 0.0, 0.0, 1.0 > /dev/null 2>&1
done 
