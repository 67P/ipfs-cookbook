# IPFS Cookbook

This cookbook installs go-ipfs and starts it as a daemon

## Requirements

### Platforms

This cookbook is tested on Ubuntu 18.06, 16.04 and Debian 9 using Test Kitchen.
It currently only supports 64bit platforms

### Chef

- Chef 12.5 or later (the cookbook provides a
  [Custom Resource](https://docs.chef.io/custom_resources.html) to configure
  go-ipfs)

### Cookbook dependencies

- `ark` to download and uncompress the go-ipfs package

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

- `node['ipfs']['version']` - the go-ipfs version to download from the official
site (64bit)
- `node['ipfs']['checksum']` - the SHA256 checksum for the package
- `node['ipfs']['config']` - a hash of config options

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

Authors: Kosmos Developers mail@kosmos.org
Copyright: 2018-2019, [Kosmos Developers](https://kredits.kosmos.org/)

```
Unless otherwise noted, all files are released under the MIT license, possible
exceptions will contain licensing information in them.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
