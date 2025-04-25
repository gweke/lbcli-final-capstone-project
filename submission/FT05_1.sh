#


#listunspent doesnt work here
# maybe bitcoin-cli -signet scantxoutset start '[{"desc":"addr(2N3J6qXQiRqp3iuf7TPX8eoCq9gGH75GV4T)","range":0}]'

#we get the tx_id directly from mempool.space
tx_id="7d2feda340254b0171b74efe6299cd157a7600904d0aa81a4d2eb7da88759c88"

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