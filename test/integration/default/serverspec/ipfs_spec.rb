require 'serverspec'

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
end
