# Only one tx in block 243,821 signals opt-in RBF. What is its txid?

block=243821

blockhash=$(bitcoin-cli -signet getblockhash $block)

# we get information about the tx which sequence is less than 2^32-1-1
tx=$(bitcoin-cli -signet getblock $blockhash 2 | jq -r '.tx[] | select(.vin[].sequence < 4294967294)')

# Then we get the txid
tx_id=$(echo $tx | jq -r '.txid')
echo $tx_id
