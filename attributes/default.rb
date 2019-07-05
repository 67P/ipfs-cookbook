node.default['ipfs']['version'] = '0.4.21'
node.default['ipfs']['checksum'] = 'a7ec5ddc4d52f818cbf3853a80f7ec17f9fde9128f039485dbe1889cf673d562'

node.default['ipfs']['ulimit'] = 64000
node.default['ipfs']['memory_max'] = "512M"
node.default['ipfs']['config'] = {
  # Do not contact local network addresses. This will stop platforms like Hetzner
  # to block your server (https://github.com/ipfs/go-ipfs/issues/1226)
  'Swarm.AddrFilters' => ['/ip4/10.0.0.0/ipcidr/8',
                          '/ip4/100.64.0.0/ipcidr/10',
                          '/ip4/169.254.0.0/ipcidr/16',
                          '/ip4/172.16.0.0/ipcidr/12',
                          '/ip4/192.0.0.0/ipcidr/24',
                          '/ip4/192.0.0.0/ipcidr/29',
                          '/ip4/192.0.0.8/ipcidr/32',
                          '/ip4/192.0.0.170/ipcidr/32',
                          '/ip4/192.0.0.171/ipcidr/32',
                          '/ip4/192.0.2.0/ipcidr/24',
                          '/ip4/192.168.0.0/ipcidr/16',
                          '/ip4/198.18.0.0/ipcidr/15',
                          '/ip4/198.51.100.0/ipcidr/24',
                          '/ip4/203.0.113.0/ipcidr/24',
                          '/ip4/240.0.0.0/ipcidr/4'],
  # Set up the Gateway to be writable
  "Gateway.Writable" => true,

  # Set up CORS headers
  "API.HTTPHeaders.Access-Control-Allow-Credentials" => ["true"],
  "API.HTTPHeaders.Access-Control-Allow-Methods" => ["PUT", "GET", "POST"],
  "API.HTTPHeaders.Access-Control-Allow-Origin" => ["*"]
}
