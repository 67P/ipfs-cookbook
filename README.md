# ipfs Cookbook

This cookbook installs ipfs and starts it as a daemon

## Requirements

### Platforms

This cookbook is tested on Ubuntu 16.06, 14.04 and Debian 8 using Test Kitchen.
It currently only supports 64bit platforms

### Chef

- Chef 12.5 or later (we are providing a
  [https://docs.chef.io/custom_resources.html](Custom Resource) to configure
  IPFS

### Cookbook dependencies

- `ark` to download and uncompress the Go IPFS package

## Usage

### ipfs::default

Just include `ipfs` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ipfs]"
  ]
}
```

## Attributes

- `node.['ipfs']['version']` - the Go IPFS version to download from the official
site (64bit)
- `node['ipfs']['checksum']` - the SHA256 checksum for the package
- `node['ipfs']['config']['swarm']['addr_filter']` - the network ranges to not
connect to. This will stop platforms like Hetzner to block your server
(https://github.com/ipfs/go-ipfs/issues/1226)

## Resources

`ipfs_config` sets the config. Supports hashes, arrays, booleans and strings.
Does not change anything if the config already has that value, and restarts
the server automatically

```ruby
ipfs_config "Gateway.Writable" do
  value "true"
 end
```

## Running the specs and integrations tests

Install the latest [Chef DK](https://downloads.chef.io/chefdk).

```
chef exec delivery local all # Run the linting check, syntax check and unit tests
kitchen verify # Run the integration tests for Ubuntu 16.04, 18.06 and Debian 9
```

## License and Authors

Authors: Kosmos

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
