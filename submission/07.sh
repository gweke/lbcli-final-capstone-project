# what is the coinbase tx in this block 243,834

block=243834
blockhash=$(bitcoin-cli -signet getblockhash $block)

# The coinbase tx is the first tx in the block

tx_id=$(bitcoin-cli -signet getblock $blockhash 2 | jq -r '.tx[0].txid')
echo $tx_id