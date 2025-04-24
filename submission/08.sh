# what block height was this tx mined ?
# 49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb

tx_id="49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb"

# Here, the height of a bloc is in getblock command output
# So we need the get the blockhash, using getrawtransaction method on the tx_id

blockhash=$(bitcoin-cli -signet getrawtransaction $tx_id true | jq -r '.blockhash')

blockheight=$(bitcoin-cli -signet getblock $blockhash | jq -r '.height')
echo $blockheight

