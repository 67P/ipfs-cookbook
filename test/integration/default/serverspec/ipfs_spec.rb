require 'serverspec'
require 'json'

# Required by serverspec
set :backend, :exec

describe 'IPFS' do
  # It is in the PATH
  describe command('which ipfs') do
    its(:exit_status) { should eq 0 }
  end

  it 'is listening on port 4001' do
    expect(port(4001)).to be_listening
  end

  it 'is listening on port 8080 (gateway)' do
    expect(port(8080)).to be_listening
  end

  it 'has a running service of ipfs' do
    expect(service('ipfs')).to be_running
    expect(service('ipfs')).to be_enabled
  end

  addr_filters = <<-EOF
[
  "/ip4/10.0.0.0/ipcidr/8",
  "/ip4/100.64.0.0/ipcidr/10",
  "/ip4/169.254.0.0/ipcidr/16",
  "/ip4/172.16.0.0/ipcidr/12",
  "/ip4/192.0.0.0/ipcidr/24",
  "/ip4/192.0.0.0/ipcidr/29",
  "/ip4/192.0.0.8/ipcidr/32",
  "/ip4/192.0.0.170/ipcidr/32",
  "/ip4/192.0.0.171/ipcidr/32",
  "/ip4/192.0.2.0/ipcidr/24",
  "/ip4/192.168.0.0/ipcidr/16",
  "/ip4/198.18.0.0/ipcidr/15",
  "/ip4/198.51.100.0/ipcidr/24",
  "/ip4/203.0.113.0/ipcidr/24",
  "/ip4/240.0.0.0/ipcidr/4"
]
  EOF

  {
    'Swarm.AddrFilters' => addr_filters.rstrip,
    'Gateway.Writable' => true,
  }.each do |k, v|
    describe command("IPFS_PATH=/home/ipfs/.ipfs ipfs config '#{k}'") do
      let(:sudo_options) { '-u ipfs -i' }
      its(:stdout) { should eq "#{v}\n" }
    end
  end
end
