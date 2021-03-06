name             'ipfs'
maintainer       'Kosmos Developers'
maintainer_email 'mail@kosmos.org'
license          'MIT'
description      'Installs/Configures ipfs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.2'

supports %w(ubuntu debian)

depends 'ark'

source_url 'https://github.com/67P/ipfs-cookbook'
issues_url 'https://github.com/67P/ipfs-cookbook/issues'
chef_version '>= 12.14' if respond_to?(:chef_version)
