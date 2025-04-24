# Which public key signed input 0 in this tx: d948454ceab1ad56982b11cf6f7157b91d3c6c5640e05c041cd17db6fff698f7

tx_id="d948454ceab1ad56982b11cf6f7157b91d3c6c5640e05c041cd17db6fff698f7"

# we'll use the getrawtransaction method, to get the details about the txid as gettransaction work only with wallet
raw_tx=$(bitcoin-cli -signet getrawtransaction $tx_id true)
#echo $raw_tx | jq

# we are dealing with segwit tx, so the pubkey is in the txinwitness and is the last element
# and our input index is 0
pubkey=$(echo $raw_tx | jq -r '.vin[0].txinwitness[-1]')
echo $pubkey