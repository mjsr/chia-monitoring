#!/bin/bash

cat /chia/logs/swar/raid0* | grep "^Total time" | awk '{ total += $4; count++ } END { print total/count }' | xargs -i date -u +%H:%M:%S -d@{}
