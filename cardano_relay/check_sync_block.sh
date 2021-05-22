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

current_block=$(cardano-cli query tip --mainnet | jq -r '.blockNo')
echo ${current_block}
