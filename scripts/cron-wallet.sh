#!/bin/bash

# Example:
# $ crontab -e
# 30 * * * * /chia/chia-monitoring/scripts/cron-wallet.sh >/dev/null 2>&1

# Where you have this repo cloned
CHIA_MONITORING_PATH=/chia/monitoring/chia-monitoring
NOTIFIER="${CHIA_MONITORING_PATH}/venv/bin/python ${CHIA_MONITORING_PATH}/discord-notify.py --config ${CHIA_MONITORING_PATH}/secrets.yaml"

# Where your chia installation is
CHIA_INSTALLATION_PATH=/chia/chia-blockchain

${CHIA_INSTALLATION_PATH}/venv/bin/chia wallet show | ${NOTIFIER}
