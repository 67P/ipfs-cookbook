#
# Cookbook Name:: ipfs
# Recipe:: cluster
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

version = node['ipfs']['cluster']['version']

ark 'ipfs-cluster-service' do
  url "https://dist.ipfs.io/ipfs-cluster-service/v#{version}/ipfs-cluster-service_v#{version}_linux-amd64.tar.gz"
  checksum node['ipfs']['cluster']['service']['checksum']
  has_binaries ['ipfs-cluster-service']
end

ark 'ipfs-cluster-ctl' do
  url "https://dist.ipfs.io/ipfs-cluster-ctl/v#{version}/ipfs-cluster-ctl_v#{version}_linux-amd64.tar.gz"
  checksum node['ipfs']['cluster']['ctl']['checksum']
  has_binaries ['ipfs-cluster-ctl']
end

credentials = data_bag_item('credentials', 'ipfs_cluster')

execute 'ipfs-cluster-service init' do
  user 'ipfs'
  environment 'CLUSTER_SECRET' => credentials['secret'],
              'IPFS_CLUSTER_PATH' => '/home/ipfs/.ipfs-cluster'
  not_if { File.exist? '/home/ipfs/.ipfs-cluster/service.json' }
end
