#5. Create 2-of-3 multisig address:
#   - Save to `multisig-address.txt`
#   - Save redeemScript to `multisig-redeem.txt`
#   - Fund using this faucet(`alt.signetfaucet.com`), and save txid to `multisig-transaction.txt`
#   - Save transaction block hash to `multisig-block.txt` and coinbase transaction to `multisig-coinbase.txt`

# we will need to generate 3 new address, get their pubkey and use them to createmultisig 

wallet_name="gweke"
address_1=$(bitcoin-cli -signet -rpcwallet=$wallet_name getnewaddress "" "bech32")
address_2=$(bitcoin-cli -signet -rpcwallet=$wallet_name getnewaddress "" "bech32")
address_3=$(bitcoin-cli -signet -rpcwallet=$wallet_name getnewaddress "" "bech32")

pubkey_1=$(bitcoin-cli -signet -rpcwallet=$wallet_name getaddressinfo $address_1 | jq -r '.pubkey')
pubkey_2=$(bitcoin-cli -signet -rpcwallet=$wallet_name getaddressinfo $address_2 | jq -r '.pubkey')
pubkey_3=$(bitcoin-cli -signet -rpcwallet=$wallet_name getaddressinfo $address_3 | jq -r '.pubkey')

echo "address_1: $address_1 ----- pubkey_1: $pubkey_1"
echo " "
echo "address_2: $address_2 ----- pubkey_2: $pubkey_2"
echo " "
echo "address_3: $address_3 ----- pubkey_3: $pubkey_3"
echo " "

nrequired=2

multisig_info=$(bitcoin-cli -signet -rpcwallet=$wallet_name createmultisig $nrequired "[\"$pubkey_1\",\"$pubkey_2\",\"$pubkey_3\"]")
echo "Multisig info"
echo $multisig_info | jq

multisig_address=$(echo "$multisig_info" | jq -r '.address')
echo "Multisig address"
echo $multisig_address

mutlisig_redeem=$(echo $multisig_info | jq -r '.redeemScript')
echo "Multisig redeemscript"
echo $mutlisig_redeem

