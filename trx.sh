#!/bin/bash

# Import the conversion functions from the external file
source ./utils.sh

set -e
trap 'echo -e "\033[31mError on line $LINENO: Command failed with exit code $?\033[0m"' ERR
LOCAL_ADDR=$(cat ./payment.addr)
TRX_AMMOUNT=$(ada_to_lovelace 20)

balance() {
    local address=$1
    lovelace_ammount=$(cardano-cli conway query utxo --address "$address" --output-json | jq '[.[] | .value.lovelace] | add')
    echo "$lovelace_ammount"
}

echo "Local Balance: $(lovelace_to_ada $(balance $LOCAL_ADDR)) Ada"
echo "Chrome Balance: $(lovelace_to_ada $(balance $RCV_ADDR)) Ada"

echo "Sending $(lovelace_to_ada $TRX_AMMOUNT) Lovelace"

HASH=$(cardano-cli query utxo --address $LOCAL_ADDR --output-json | jq -r 'keys[]')

echo "then hash is $HASH"

cardano-cli conway transaction build \
    --tx-in $HASH \
    --tx-out $RCV_ADDR+$TRX_AMMOUNT \
    --change-address $LOCAL_ADDR \
    --out-file tx/tx.raw

calc_fee() {
    FEE=$(cardano-cli conway transaction calculate-min-fee \
        --tx-body-file tx/tx.draft \
        --protocol-params-file pparams.json \
        --witness-count 1)
    echo "Transaction Fee: $FEE"
}

cardano-cli conway transaction sign \
    --tx-body-file tx/tx.raw \
    --signing-key-file payment.skey \
    --out-file tx/tx.signed

cardano-cli conway transaction submit \
    --tx-file tx/tx.signed

TRX_ID=$(cardano-cli conway transaction txid --tx-file tx/tx.signed)
echo "Transcation link: https://preprod.cardanoscan.io/transaction/$TRX_ID"

echo "Local Balance: $(lovelace_to_ada $(balance $LOCAL_ADDR)) Ada"
echo "Chrome Balance: $(lovelace_to_ada $(balance $RCV_ADDR)) Ada"
