#!/bin/bash

NOTIFIER="/chia/chia-tools/venv/bin/python /chia/chia-tools/discord-notify.py --config /chia/chia-tools/secrets.yaml"

cd /chia/chia-blockchain
. ./activate
chia wallet show | ${NOTIFIER}
deactivate
cd -

