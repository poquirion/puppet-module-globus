# puppet-globus

[![Puppet Forge](http://img.shields.io/puppetforge/v/poquirion/globus.svg)](https://forge.puppetlabs.com/poquirion/globus)
[![CI Status](https://github.com/poquirion/puppet-module-globus/workflows/CI/badge.svg?branch=master)](https://github.com/poquirion/puppet-module-globus/actions?query=workflow%3ACI)

## Overview

This module manages Globus Connect Server.

### Supported Versions of Globus

Currently this module supports Globus 5.4, at least 5.4.61

| Globus Version | Globus Puppet module versions |
| -------------- | ----------------------------- |
| 5.4.71         | 11.x                          |

## Usage

### Globus v5.4

The steps performed by this module are to install Globus and run the `globus endpoint setup` and `globus node setup` commands.

The following is the minimum parameters that must be passed to setup Globus v5.4.

```puppet
class { 'globus':
  display_name   => 'REPLACE My Site Globus',
  organization   => 'REPLACE My Organisation',
  owner          => 'REPLACE-user@example.com',
  contact_email  => ''REPLACE-user@example.com'',
  ip_address     => 'REPLACE Public IP',
  users          => {'REPLACE user1 name on host': 
                            globus_id: 'REPLACE user1 Public Globus ID',
                    'REPLACE user2 name on host': 
                            globus_id: 'REPLACE user2 Public Globus ID' [ ... ] }

}
```

Users will have their `$HOME` folder exposed in a Globus Collection searchable under _display_name_

An extra variable can be added to expose specific path on the host along with the users `$HOME`

```puppet 
class { 'globus':
  display_name   => 'REPLACE My Site Globus',
  organization   => 'REPLACE My Organisation',
  owner          => 'REPLACE-user@example.com',
  contact_email  => ''REPLACE-user@example.com'',
  ip_address     => 'REPLACE Public IP',
  users          => {'REPLACE user1 name on host':
                            globus_id: 'REPLACE user1 Public Globus ID',
                    'REPLACE user2 name on host':
                            globus_id: 'REPLACE user2 Public Globus ID' [ ... ] }
  exposed_paths  => [ 'REPLACE path to expose', [...] ]
}

```

   User will be able to acces their data on the Globus page by using the pasword associated with their 
globus id, be carful not to enter the wrong ID there!  


### Globus CLI

To install the Globus CLI to `/opt/globus-cli` and create symlink for executable at `/usr/bin/globus`:

```puppet
include globus::cli
```

### Globus Timer

To install the Globus Timer CLI to `/opt/globus-timer` and create symlink for executable at `/usr/bin/globus-timer`:

```puppet
include globus::timer
```

### Globus SDK

To install the Globus SDK to `/opt/globus-sdk`:

```puppet
include globus::sdk
```

### Facts

The `globus_info` fact exposes the information stored in `/var/lib/globus-connect-server/info.json`.  Example:

```
# facter -p globus_info
{
  endpoint_id => "1c6b6e6a-3791-4213-b3e6-00000001",
  domain_name => "00000001.8443.data.globus.org",
  manager_version => "5.4.11",
  DATA_TYPE => "info#1.0.0",
  client_id => "1c6b6e6a-3791-4213-b3e6-00000001",
  api_version => "1.3.0"
}

```

## Compatibility

Tested using

* RedHat/Rocky 8
* Debian 11

