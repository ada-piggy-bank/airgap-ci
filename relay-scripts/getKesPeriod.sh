#!/bin/bash
currentSlot=$(cardano-cli query tip --mainnet | jq -r '.slot')
expiry=expr $currentSlot
echo Current Tip: $currentSlot
slotsPerKESPeriod=$(cat $NODE_HOME/${NODE_CONFIG}-shelley-genesis.json | jq -r '.slotsPerKESPeriod')
echo slotsPerKESPeriod: ${slotsPerKESPeriod}
kesPeriod=$((currentSlot / slotsPerKESPeriod))
echo Kes Period: $kesPeriod
qrencode -t ansiutf8 $kesPeriod
