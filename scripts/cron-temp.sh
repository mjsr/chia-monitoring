#!/bin/bash

NOTIFIER="/chia/chia-tools/venv/bin/python /chia/chia-tools/discord-notify.py --config /chia/chia-tools/secrets.yaml"


TEMPS="Storage temperature:"

for d in "nvme0n1" "nvme1n1" "nvme2n1" "nvme3n1" "nvme4n1"
do
TEMP=$(/usr/sbin/smartctl --all /dev/${d} | grep "^Temperature" | tr -s [:space:] | awk -v device="${d}" '{print device ": " $2}')
TEMPS="$TEMPS\n$TEMP°C"
done

for d in "sda"
do
TEMP=$(/usr/sbin/smartctl --all /dev/${d} | grep "Temperature_Celsius" | awk -v device="${d}" '{print device ": " $10}')
TEMPS="$TEMPS\n$TEMP°C"
done

echo -e $TEMPS | $NOTIFIER
