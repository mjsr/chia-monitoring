#!/bin/bash

# Example:
# $ crontab -e
# 59 * * * * /chia/chia-monitoring/scripts/cron-stats.sh >/dev/null 2>&1

# Where you have this repo cloned
CHIA_MONITORING_PATH=/chia/chia-monitoring
NOTIFIER="${CHIA_MONITORING_PATH}/venv/bin/python ${CHIA_MONITORING_PATH}/discord-notify.py --config ${CHIA_MONITORING_PATH}/secrets.yaml"

# Where you have your chia plots create logs
CHIA_PLOTS_LOGS_PATH=/chia/logs/swar

MESSAGE="Phase 1 average time:"
ALL_PLOTS=$(grep -rh "^Time for phase 1" ${CHIA_PLOTS_LOGS_PATH} | awk '{ total += $6; count++ } END { print total/count }' | xargs -i date -u +%H:%M:%S -d@{})

MESSAGE="${MESSAGE}\n\tFor all plots: ${ALL_PLOTS}"

for n in {5..3}; do
    LAST_N=$(ls -tr ${CHIA_PLOTS_LOGS_PATH} | xargs -i cat {} | grep "^Time for phase 1" | tail -n${n} | awk '{ total += $6; count++ } END { print total/count }' | xargs -i date -u +%H:%M:%S -d@{})
    MESSAGE="${MESSAGE}\n\tFor last ${n} plots: ${LAST_N}"
done

ALL_PLOTS=$(grep -rh "^Total time" ${CHIA_PLOTS_LOGS_PATH} | awk '{ total += $4; count++ } END { print total/count }' | xargs -i date -u +%H:%M:%S -d@{})

MESSAGE="${MESSAGE}\n\nCompletion average time:"
MESSAGE="${MESSAGE}\n\tFor all plots: ${ALL_PLOTS}"

for n in {5..3}; do
    LAST_N=$(ls -tr ${CHIA_PLOTS_LOGS_PATH} | xargs -i cat {} | grep "^Total time" | tail -n${n} | awk '{ total += $4; count++ } END { print total/count }' | xargs -i date -u +%H:%M:%S -d@{})
    MESSAGE="${MESSAGE}\n\tFor last ${n} plots: ${LAST_N}"
done

echo -e $MESSAGE | $NOTIFIER
