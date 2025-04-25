#3. Fund the address using this faucet (`alt.signetfaucet.com`) and save to files:
#   - `transaction-1.txt` (txid)
#   - `block-1.txt` (blockhash for the transaction)
#   - `coinbase-1.txt` (coinbase transaction in the block)

wallet_name="gweke"

# we list unspent to get tx_id and vout
utxos=$(bitcoin-cli -signet -rpcwallet=$wallet_name listunspent)
#echo $utxos | jq

tx_id=$(echo $utxos | jq -r '.[0].txid')
vout_index=$(echo $utxos | jq -r '.[0].vout')
echo "utxos tx_id"
echo $tx_id

echo "utxos vout_index"
echo $vout_index

blockhash=$(bitcoin-cli -signet getrawtransaction $tx_id true | jq -r '.blockhash')
echo "utxos tx_id blockhash"
echo $blockhash

blockheight=$(bitcoin-cli -signet getblock $blockhash | jq -r '.height')
echo "utxos tx_id blockheight"
echo $blockheight

# The coinbase tx is the first tx in the block (in the tx block)
coinbase_tx_id=$(bitcoin-cli -signet getblock $blockhash 2 | jq -r '.tx[0].txid')
echo "coinbase tx_id in the utxos tx_id block"
echo $coinbase_tx_id