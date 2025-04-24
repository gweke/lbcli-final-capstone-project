#2. Create a native SegWit address
wallet_name="gweke"

segwit_addr=$(bitcoin-cli -signet -rpcwallet=$wallet_name getnewaddress "" "bech32")
echo $segwit_addr