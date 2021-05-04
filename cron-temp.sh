#!/bin/bash

NOTIFIER="/chia/chia-tools/venv/bin/python /chia/chia-tools/discord-notify.py --config /chia/chia-tools/secrets.yaml"

TEMPS="Temperature of the NVMEs: "

# Board

TEMP=$(smartctl --all /dev/nvme0n1 | grep "^Temperature" | tr -s [:space:] | awk '{print $2}')
TEMPS="$TEMPS $TEMP"

# Raid
for n in {1..4}
do
TEMP=$(smartctl --all /dev/nvme${n}n1 | grep "^Temperature" | tr -s [:space:] | awk '{print $2}')
TEMPS="$TEMPS $TEMP"
done

echo $TEMPS | $NOTIFIER
