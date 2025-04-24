# Which tx in block 216,351 spends the coinbase output of block 216,128?

coinbase_block=216128
spent_coinbase_block=216351

# we get the blockhash, then use the getblock blockhash 2 or 3 to get information, and use jq to get the txid of coinbase
# we do the same with the spent_coinbase_block, then there we look for our txid and vout

coinbase_blockhash=$(bitcoin-cli -signet getblockhash $coinbase_block)
#echo $coinbase_blockhash

spent_coinbase_blockhash=$(bitcoin-cli -signet getblockhash $spent_coinbase_block)
#echo $spent_coinbase_blockhash

# The coinbase is the first tx in the block, so tx[0]
coinbase_txid=$(bitcoin-cli -signet getblock $coinbase_blockhash 2 | jq -r '.tx[0].txid')
#echo $coinbase_txid

# so in the the block that spent the coinbase, we'll look for the coinbase txid with select
#tx=$(bitcoin-cli -signet getblock $spent_coinbase_blockhash 2 | jq --arg coinbase_txid "$coinbase_txid" '.tx[] | select(.vin[].txid == $coinbase_txid)')
tx=$(bitcoin-cli -signet getblock $spent_coinbase_blockhash 2 | jq ".tx[] | select(.vin[].txid == \"$coinbase_txid\")")
#echo $tx | jq

txid=$(echo $tx | jq -r '.txid')
echo $txid

