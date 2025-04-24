# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb

tx_id="b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb"

# so to know the fees, we'll sum up the output, and then the input and the diference will be the fees

# For the output, they are all list in the transaction when using getrawtransaction, 
raw_tx=$(bitcoin-cli -signet getrawtransaction $tx_id true)
#echo $raw_tx | jq

output_value_sat=$(echo $raw_tx | jq -r '[.vout[].value * 100000000] | add')
#echo $output_value_sat

# but for the input we need to through each txid an vout index to get their value
# chances are, here we have onlt one vin and vout=0
input_txid=$(echo $raw_tx | jq -r '.vin[0].txid')
vout_input_txid=$(echo $raw_tx | jq -r '.vin[0].vout')

raw_input_tx=$(bitcoin-cli -signet getrawtransaction $input_txid true)
#echo $raw_input_tx | jq

input_value_sat=$(echo $raw_input_tx | jq -r ".vout[$vout_input_txid].value * 100000000")
#echo $input_value_sat

fees=$((input_value_sat - output_value_sat))
echo $fees
