#!/bin/bash

MESSAGE="Phase 1 average time:"
ALL_PLOTS=$(cat /chia/logs/swar/raid0* | grep "^Time for phase 1" | awk '{ total += $6; count++ } END { print total/count }' | xargs -i date -u +%H:%M:%S -d@{})

MESSAGE="${MESSAGE}\n\tFor all plots: ${ALL_PLOTS}"

for n in {5..3}
do
LAST_N=$(ls -tr /chia/logs/swar/raid0* | xargs -I{} cat {} | grep "^Time for phase 1" | tail -n${n} | awk '{ total += $6; count++ } END { print total/count }' | xargs -i date -u +%H:%M:%S -d@{})
MESSAGE="${MESSAGE}\n\tFor last ${n} plots: ${LAST_N}"
done

echo -e $MESSAGE
