tx_id="e1f813e28ad827cb09bf7e9ddfb90c655f16624d49befe6e867fc8f245dea598"

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