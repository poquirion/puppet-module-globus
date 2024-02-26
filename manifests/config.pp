# @summary Manage globus configs
# @api private
class globus::config {

  file { '/root/mapping.json':
    ensure    => 'file',
    owner     => 'root',
    group     => 'root',
    mode      => '0600',
    content => template('globus/mapping.json.erb'),
  }

  file { '/root/restriction.json':
    ensure    => 'file',
    owner     => 'root',
    group     => 'root',
    mode      => '0600',
    content => template('globus/restriction.json.erb'),
  }

  file { '/root/globus-full-setup.sh':
    ensure    => 'file',
    owner     => 'root',
    group     => 'root',
    mode      => '0700',
    content => template('globus/globus-full-setup.sh.erb'),
  }

  file { '/root/globus-cleanup.sh':
    ensure    => 'file',
    owner     => 'root',
    group     => 'root',
    mode      => '0700',
    content => template('globus/globus-cleanup.sh.erb'),
  }

  file { '/root/update_mapping.sh':
    ensure    => 'file',
    owner     => 'root',
    group     => 'root',
    mode      => '0700',
    content => template('globus/update_mapping.sh.erb'),
  }

  exec { 'update_mapping':
    path        => '/usr/bin:/usr/sbin:/bin',
    command     => '/root/update_mapping.sh',
    refreshonly => true,
    subscribe   => File['/root/mapping.json'],
  }

  if ! empty($globus::extra_gridftp_settings) {
    file { '/etc/gridftp.d/z-extra-settings':
      ensure  => 'file',
      content => template('globus/gridftp-extra-settings.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => $globus::notify_service,
    }
  }

  if $globus::manage_firewall {
    firewall { '500 allow HTTPS':
      action => 'accept',
      dport  => '443',
      proto  => 'tcp',
    }

    firewall { '500 allow GridFTP data channels':
      action => 'accept',
      dport  => join($globus::incoming_port_range, '-'),
      proto  => 'tcp',
    }
  }
}
