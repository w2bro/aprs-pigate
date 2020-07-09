#!/bin/bash

if test -f "/boot/DISABLE_SDR"; then
    direwolf -c /home/pi/pigate-direwolf.conf -L /home/pi/aprslogs/aprs.log
else
    rtl_fm -f 144.39M | direwolf -c /home/pi/pigate-direwolf.conf -L /home/pi/aprslogs/aprs.log
fi
