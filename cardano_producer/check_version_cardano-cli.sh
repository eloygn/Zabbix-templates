#!/bin/bash
export LD_LIBRARY_PATH=/usr/local/lib:
export NODE_HOME=/var/lib/cardano
export NODE_CONFIG=mainnet
export NODE_BUILD_NUM=5070119
export CARDANO_NODE_SOCKET_PATH=/var/lib/cardano/relay/db/node.socket
cardano-cli version
