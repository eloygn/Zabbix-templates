#!/bin/bash
export LD_LIBRARY_PATH=/usr/local/lib:
export NODE_HOME=/var/lib/cardano
export NODE_CONFIG=mainnet
export NODE_BUILD_NUM=5070119
export CARDANO_NODE_SOCKET_PATH=/var/lib/cardano/relay/db/node.socket

GENESIS=/var/lib/cardano/mainnet-shelley-genesis.json
BYRON_GENESIS=/var/lib/cardano/mainnet-byron-genesis.json
HARDFORK_EPOCH=1 # MC4 only, to be updated for mainnet
NETWORK="--mainnet" # replace by --mainnet for mainnet

epoch_length=$(jq -r .epochLength $GENESIS)
slot_length=$(jq -r .slotLength $GENESIS)
byron_slot_length=$(( $(jq -r .blockVersionData.slotDuration $BYRON_GENESIS) / 1000 ))
byron_epoch_length=$(( $(jq -r .protocolConsts.k $BYRON_GENESIS) * 10 ))

byron_start=$(jq -r .startTime $BYRON_GENESIS)
byron_end=$((byron_start + HARDFORK_EPOCH * byron_epoch_length * byron_slot_length))
byron_slots=$(($HARDFORK_EPOCH * byron_epoch_length))
now=$(date +'%s')

expected_slot=$((byron_slots + (now - byron_end) / slot_length))
current_slot=$(cardano-cli query tip $NETWORK | jq -r '.slotNo')
percent=$(echo -e "scale=2\n$current_slot * 100 / $expected_slot" | bc)

echo "slot ${current_slot}/${expected_slot} ${percent}%"
