#
# Cookbook Name:: ipfs
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright:: 2018, Kosmos Developers
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

include_recipe 'ipfs::_user'

version = node['ipfs']['version']

ark 'ipfs' do
  url "https://dist.ipfs.io/go-ipfs/v#{version}/go-ipfs_v#{version}_linux-amd64.tar.gz"
  checksum node['ipfs']['checksum']
  has_binaries ['ipfs']
end

execute 'ipfs init --empty-repo' do
  environment 'IPFS_PATH' => '/home/ipfs/.ipfs'
  user 'ipfs'
  not_if { File.directory? '/home/ipfs/.ipfs' }
end

if platform?('ubuntu') && node['platform_version'].to_f < 15.04 ||
   platform?('debian') && node['platform_version'].to_f < 8
  template 'ipfs.initd.service.erb' do
    path '/etc/init.d/ipfs'
    source 'ipfs.initd.service.erb'
    owner 'root'
    group 'root'
    mode '0750'
    notifies :restart, 'service[ipfs]', :delayed
  end

  service 'ipfs' do
    provider Chef::Provider::Service::Init::Debian
    action [:enable]
    supports start: true, stop: true, restart: true, reload: false, status: true
  end

else
  execute 'systemctl daemon-reload' do
    command 'systemctl daemon-reload'
    action :nothing
  end

  template 'ipfs.systemd.service.erb' do
    path '/lib/systemd/system/ipfs.service'
    source 'ipfs.systemd.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :run, 'execute[systemctl daemon-reload]', :delayed
    notifies :restart, 'service[ipfs]', :delayed
  end

  service 'ipfs' do
    provider Chef::Provider::Service::Systemd
    action [:enable]
  end
end

# Configure ipfs to not contact local network addresses
ipfs_config 'Swarm.AddrFilters' do
  value node['ipfs']['config']['swarm']['addr_filter']
end

# Do not keep track of bandwidth metrics. Disabling bandwidth metrics can
# lead to a slight performance improvement, as well as a reduction in memory
# usage.
ipfs_config 'Swarm.DisableBandwidthMetrics' do
  value true
end

# Disable the p2p-circuit relay transport
ipfs_config 'Swarm.DisableRelay' do
  value true
end

# Number of connections that, when exceeded, will trigger a connection GC
# operation
ipfs_config 'Swarm.ConnMgr.HighWater' do
  value 10
end

# Minimum number of connections to maintain
ipfs_config 'Swarm.ConnMgr.LowWater' do
  value 1
end
