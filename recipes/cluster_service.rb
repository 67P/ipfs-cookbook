#
# Cookbook Name:: ipfs
# Recipe:: cluster_service
#
# Copyright 2018, Kosmos
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
