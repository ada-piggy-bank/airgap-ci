#!/bin/bash
currentSlot=$(cardano-cli query tip --mainnet | jq -r '.slot')
expiry=expr $currentSlot
echo Current Tip: $currentSlot
qrencode -t ansiutf8 $currentSlot
