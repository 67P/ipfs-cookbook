require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'ipfs-cluster-ctl' do
  # It is in the PATH
  describe command('which ipfs-cluster-ctl') do
    its(:exit_status) { should eq 0 }
  end
end

describe 'ipfs-cluster-service' do
  # It is in the PATH
  describe command('which ipfs-cluster-service') do
    its(:exit_status) { should eq 0 }
  end

  it 'is listening on port 9096' do
    expect(port(9096)).to be_listening
  end

  it 'runs the ipfs-cluster-service' do
    expect(service('ipfs-cluster')).to be_running
    expect(service('ipfs-cluster')).to be_enabled
  end
end
