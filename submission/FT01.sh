wallet_name="gweke"

echo $(bitcoin-cli -signet createwallet $wallet_name)

#echo "Load the wallet : $wallet_name"
load_wallet=$(bitcoin-cli -signet loadwallet $wallet_name)
echo $load_wallet

#echo "Get the wallet info : $wallet_name"
echo $(bitcoin-cli -signet -rpcwallet=$wallet_name getwalletinfo)