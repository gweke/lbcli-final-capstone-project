# How many new outputs were created by block 243,825?

block=243825
blockstats=$(bitcoin-cli -signet getblockstats $block)
echo $blockstats | jq '.outs'