
#4. Spend from funded address by creating a transaction with details below:
#   - Send exactly 10,000 sats to `tb1qddpcyus3u603n63lk7m5epjllgexc24vj5ltp7`
#   - Use transaction Fee: 700 sats
#   - Make sure transaction fee can be later updated to a higher fee
#   - Broadcast transaction
#   - Save txid to `transaction-2.txt`
#   - Save transaction block hash to `block-2.txt` and coinbase transaction to `coinbase-2.txt`

wallet_name="gweke"

recipient="tb1qddpcyus3u603n63lk7m5epjllgexc24vj5ltp7"
amount_to_send=10000
fees=700
rbf_sequence=1

# Here we'll create the raw transaction using 
#inputs (txid:utxos_txid vout:vout_index sequence=$rbf_sequence) 
# output (recipient:amout_to_send change_address:change_amount using getrawchangeaddress)

# We use part of previous code in FT03.sh
# we list unspent to get tx_id and vout
utxos=$(bitcoin-cli -signet -rpcwallet=$wallet_name listunspent)
echo $utxos | jq

utxos_tx_id=$(echo $utxos | jq -r '.[0].txid')
utxo_vout_index=$(echo $utxos | jq -r '.[0].vout')
utxo_value_btc=$(echo $utxos | jq -r '.[0].amount')
utxo_value=$(echo $utxos | jq -r '.[0].amount * 100000000 | floor')
#utxo_value=$((utxo_value_btc * 100000000 | floor))

echo "utxos tx_id"
echo $utxos_tx_id
echo "vout index"
echo $utxo_vout_index
echo "utxo value"
echo " in btc $utxo_value_btc and in sat $utxo_value"

change_address=$(bitcoin-cli -signet -rpcwallet=$wallet_name getrawchangeaddress "bech32")
echo "change address"
echo $change_address

change_amount=$((utxo_value - amount_to_send - fees))
echo "change_amount"
echo $change_amount

tx_inputs="[{\"txid\": \"$utxos_tx_id\", \"vout\": $utxo_vout_index, \"sequence\": $rbf_sequence}]"

# Convert amounts to BTC for createrawtransaction
amount_to_send_btc=$(printf "%.8f" "$(bc -l <<< "scale=8; $amount_to_send / 100000000")")
change_btc=$(printf "%.8f" "$(bc -l <<< "scale=8; $change_amount / 100000000")")

echo "amount to send btc: $amount_to_send_btc change amount btc: $change_btc"


tx_outputs="{\"$recipient\": $amount_to_send_btc, \"$change_address\": $change_btc}"

raw_tx=$(bitcoin-cli -signet createrawtransaction "$tx_inputs" "$tx_outputs")
echo "raw tx hex"
echo $raw_tx

# Sign transaction
signed_hex=$(bitcoin-cli -signet -rpcwallet=$wallet_name signrawtransactionwithwallet $raw_tx | jq -r '.hex')
echo "signed tx hex or send tx_id"
echo $signed_hex

#broadcast it
send_tx_id=$(bitcoin-cli -signet -rpcwallet=$wallet_name sendrawtransaction $signed_hex)
echo "send tx_id with sendrawtransaction"
echo $send_tx_id

# we can also decoderawtransaction to get the information we want and to verify
decode_tx=$(bitcoin-cli -signet decoderawtransaction $raw_tx)
echo "decode raw tx"
echo $decode_tx | jq

send_tx_id_verify=$(echo $decode_tx | jq -r '.txid')
echo "send_tx_id to check if it's the same as send_tx_id"
echo $send_tx_id_verify
