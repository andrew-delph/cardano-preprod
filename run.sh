#!/bin/bash


cardano-node run \
  --topology $HOME/cardano/preprod/config/topology.json \
  --database-path $HOME/cardano/preprod/db \
  --socket-path $HOME/cardano/preprod/db/node.socket \
  --host-addr 0.0.0.0 \
  --port 3001 \
  --config $HOME/cardano/preprod/config/config.json \
  +RTS -N -A16m -H2G -RTS


