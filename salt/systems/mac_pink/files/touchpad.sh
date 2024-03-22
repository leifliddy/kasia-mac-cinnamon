#!/bin/bash

id=$(xinput list | grep "Apple SPI Touchpad" | awk '{print $6}' | sed 's/id=//')
state=$(xinput list-props $id | grep 'Device Enabled' | grep -o '[01]$')

#[[ $1 == 'off' ]] && xinput disable $id && exit   ##for udev rule
#[[ $1 == 'on' ]] && xinput enable $id && exit   ##for udev rule

[[ $state == '1' ]] && xinput disable $id || xinput enable $id

