name 'elastic_beats'
maintainer 'Alain Lefebvre'
maintainer_email 'hartfordfive@gmail.com'
license 'Apache 2'
description 'Installs/Configures elastic_beats'
long_description 'Installs/Configures elastic_beats'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/hartfordfive/elastic_beats/issues'
source_url 'https://github.com/hartfordfive/elastic_beats'

depends 'filebeat', '~> 1.4.0'
