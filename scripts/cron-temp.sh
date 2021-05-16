#!/bin/bash

# Needs to be run as root: sudo crontab -e
# Example:
# 15,45 * * * * /chia/chia-monitoring/scripts/cron-temp.sh >/dev/null 2>&1

# Where you have this repo cloned
CHIA_MONITORING_PATH=/chia/monitoring/chia-monitoring
NOTIFIER="${CHIA_MONITORING_PATH}/venv/bin/python ${CHIA_MONITORING_PATH}/discord-notify.py --config ${CHIA_MONITORING_PATH}/secrets.yaml"

TEMP=$(/usr/bin/sensors | grep Tctl | awk '{print $2}' | sed 's/[^0-9\.]*//g')
TEMPS="CPU: $TEMP°C"

TEMPS="$TEMPS\nStorage temperature:"

# Example line
# Temperature:                        27 Celsius
for d in "nvme0n1" "nvme1n1" "nvme2n1" "nvme3n1" "nvme4n1"; do
    TEMP=$(/usr/sbin/smartctl --all /dev/${d} | grep "^Temperature" | tr -s [:space:] | awk -v device="${d}" '{print device ": " $2}')
    TEMPS="$TEMPS\n\t$TEMP°C"
done

# Example line
# 194 Temperature_Celsius     0x0022   032   041   000    Old_age   Always       -       32 (0 24 0 0 0)
for d in "sda" "sdb" "sdc" "sdd"; do
    TEMP=$(/usr/sbin/smartctl --all /dev/${d} | grep "Temperature_Celsius" | awk -v device="${d}" '{print device ": " $10}')
    TEMPS="$TEMPS\n\t$TEMP°C"
done

echo -e $TEMPS | $NOTIFIER
