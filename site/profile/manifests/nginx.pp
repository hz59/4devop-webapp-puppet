class profile::nginx {
  
  package { 'Install nginx':
    ensure => installed,
    name => 'nginx'
  }
  package { 'Install git':
    ensure => present,
    name => 'git'
  }
  tidy {'remove default site':
    recurse => true,
    rmdirs => true,
    path => '/usr/share/nginx/html/'
  }
  vcsrepo { '/usr/share/nginx/html':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/diranetafen/static-website-example.git',
  }
  firewall { '100 allow http and https access':
    dport    => [80, 443],
    proto    => 'tcp',
    action   => 'accept',
  }
  file_line { 'Replace conf':
    path => '/etc/nginx/nginx.conf',
    replace => true,
    line => '8080 default_server',
    match => '80 default_server',
    multiple => true
  }
  service { nginx:
    ensure => running,
    enable => true,
  }
}
