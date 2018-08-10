require 'json'
require 'mixlib/shellout'

property :key, String, name_property: true
property :value, [String, Hash, Array, TrueClass, FalseClass], required: true

action :create do
  include_recipe 'ipfs'

  execute "ipfs config --json #{new_resource.key} '#{JSON.generate(new_resource.value)}'" do
    environment 'IPFS_PATH' => '/home/ipfs/.ipfs'
    user 'ipfs'
    not_if do
      cmd = Mixlib::ShellOut.new('ipfs', 'config', new_resource.key,
                                 user: 'ipfs',
                                 env: { 'IPFS_PATH' => '/home/ipfs/.ipfs' })
      cmd.run_command
      begin
        JSON.parse(cmd.stdout) == JSON.parse(JSON.generate(new_resource.value))
      rescue JSON::ParserError
        cmd.stdout.include?(new_resource.value.to_s)
      end
    end
    notifies :restart, 'service[ipfs]', :delayed
  end
end
