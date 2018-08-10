#
# Cookbook Name:: ipfs
# Recipe:: cluster
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

include_recipe 'ipfs::_user'

version = node['ipfs']['cluster']['version']

ark 'ipfs-cluster-service' do
  url "https://dist.ipfs.io/ipfs-cluster-service/v#{version}/ipfs-cluster-service_v#{version}_linux-amd64.tar.gz"
  has_binaries ['ipfs-cluster-service']
end

ark 'ipfs-cluster-ctl' do
  url "https://dist.ipfs.io/ipfs-cluster-ctl/v#{version}/ipfs-cluster-ctl_v#{version}_linux-amd64.tar.gz"
  has_binaries ['ipfs-cluster-ctl']
end

credentials = data_bag_item('credentials', 'ipfs_cluster')

execute 'ipfs-cluster-service init' do
  user 'ipfs'
  environment 'CLUSTER_SECRET' => credentials['secret'],
              'IPFS_CLUSTER_PATH' => '/home/ipfs/.ipfs-cluster'
  not_if { File.exist? '/home/ipfs/.ipfs-cluster/service.json' }
end
