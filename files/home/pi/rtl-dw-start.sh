#!/bin/bash

rtl_fm -f 144.39M - | direwolf -c /home/pi/direwolf/sdr.conf -r 24000 -D 1 -
