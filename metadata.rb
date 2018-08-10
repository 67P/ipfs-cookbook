name             'ipfs'
maintainer       'Kosmos'
maintainer_email 'mail@kosmos.org'
license          'Apache-2.0'
description      'Installs/Configures ipfs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports %w(ubuntu debian)

depends 'ark'

source_url 'https://github.com/67P/ipfs-cookbook'
issues_url 'https://github.com/67P/ipfs-cookbook/issues'
chef_version '>= 12.14' if respond_to?(:chef_version)
