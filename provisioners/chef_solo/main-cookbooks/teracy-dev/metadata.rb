name             'teracy-dev'
maintainer       'Teracy, Inc.'
maintainer_email 'hoatlevan@gmail.com'
license          'All rights reserved'
description      'Installs/Configures teracy-dev'
version          '0.3.0'
issues_url 'https://github.com/teracyhq/issues'
source_url 'https://github.com/teracyhq/issues'

%w( magic_shell docker docker_compose ).each do |dep|
  depends dep
end
