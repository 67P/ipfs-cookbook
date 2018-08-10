node.default['ipfs']['version'] = '0.4.9'
node.default['ipfs']['checksum'] = 'ae50c760f58548adc7c6dade4cf549059b6bc73ebc25ff4ea9fece06a15ac0a6'
# Do not contact local network addresses. This will stop platforms like Hetzner
# to block your server (https://github.com/ipfs/go-ipfs/issues/1226)
node.default['ipfs']['config']['swarm']['addr_filter'] = ['/ip4/10.0.0.0/ipcidr/8', '/ip4/100.64.0.0/ipcidr/10', '/ip4/169.254.0.0/ipcidr/16', '/ip4/172.16.0.0/ipcidr/12', '/ip4/192.0.0.0/ipcidr/24', '/ip4/192.0.0.0/ipcidr/29', '/ip4/192.0.0.8/ipcidr/32', '/ip4/192.0.0.170/ipcidr/32', '/ip4/192.0.0.171/ipcidr/32', '/ip4/192.0.2.0/ipcidr/24', '/ip4/192.168.0.0/ipcidr/16', '/ip4/198.18.0.0/ipcidr/15', '/ip4/198.51.100.0/ipcidr/24', '/ip4/203.0.113.0/ipcidr/24', '/ip4/240.0.0.0/ipcidr/4']

node.default['ipfs']['cluster']['version'] = '0.4.0'
