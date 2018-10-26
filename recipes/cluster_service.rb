#
# Cookbook Name:: ipfs
# Recipe:: cluster_service
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

if platform?('ubuntu') && node['platform_version'].to_f < 15.04 ||
   platform?('debian') && node['platform_version'].to_f < 8
  template 'ipfs.initd-cluster.service.erb' do
    path '/etc/init.d/ipfs-cluster'
    source 'ipfs-cluster.initd.service.erb'
    owner 'root'
    group 'root'
    mode '0750'
    notifies :restart, 'service[ipfs-cluster]', :delayed
  end

  service 'ipfs-cluster' do
    provider Chef::Provider::Service::Init::Debian
    action [:enable]
    supports start: true, stop: true, restart: true, reload: false, status: true
  end

else
  execute 'systemctl daemon-reload' do
    command 'systemctl daemon-reload'
    action :nothing
  end

  template 'ipfs-cluster.systemd.service.erb' do
    path '/lib/systemd/system/ipfs-cluster.service'
    source 'ipfs-cluster.systemd.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :run, 'execute[systemctl daemon-reload]', :delayed
    notifies :restart, 'service[ipfs-cluster]', :delayed
  end

  service 'ipfs-cluster' do
    provider Chef::Provider::Service::Systemd
    action [:enable]
  end
end
