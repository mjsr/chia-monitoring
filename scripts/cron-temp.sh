#!/bin/bash

# Needs to be run as root: sudo crontab -e
# Example:
# 15,45 * * * * /chia/chia-monitoring/scripts/cron-temp.sh >/dev/null 2>&1

# Where you have this repo cloned
CHIA_MONITORING_PATH=/chia/chia-monitoring
NOTIFIER="${CHIA_MONITORING_PATH}/venv/bin/python ${CHIA_MONITORING_PATH}/discord-notify.py --config ${CHIA_MONITORING_PATH}/secrets.yaml"

TEMPS="Storage temperature:"

for d in "nvme0n1" "nvme1n1" "nvme2n1" "nvme3n1" "nvme4n1"; do
    TEMP=$(/usr/sbin/smartctl --all /dev/${d} | grep "^Temperature" | tr -s [:space:] | awk -v device="${d}" '{print device ": " $2}')
    TEMPS="$TEMPS\n$TEMP°C"
done

for d in "sda"; do
    TEMP=$(/usr/sbin/smartctl --all /dev/${d} | grep "Temperature_Celsius" | awk -v device="${d}" '{print device ": " $10}')
    TEMPS="$TEMPS\n$TEMP°C"
done

echo -e $TEMPS | $NOTIFIER
