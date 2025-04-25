#2. Create a native SegWit address
# - Add your address to the `address.txt` file

wallet_name="gweke"

segwit_addr=$(bitcoin-cli -signet -rpcwallet=$wallet_name getnewaddress "" "bech32")
echo $segwit_addr