#
# freeradius module
#
# Copyright 2010, Atizo AG
# Simon Josi simon.josi+puppet(at)atizo.com
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class freeradius {
  package{[
    'freeradius2',
    'freeradius2-utils',
  ]:
    ensure => present,
  }
  service{'radiusd':
    hasstatus => true,
    ensure => running,
    enable => true,
    require => Exec['freeradius-certificates'],
  }
  exec{'freeradius-certificates':
    command => 'make -C /etc/raddb/certs',
    creates => '/etc/raddb/certs/server.crt',
  }
  file{'/etc/raddb/radiusd.conf':
    source => [
      "puppet://$server/modules/site-freeradius/$fqdn/radiusd.conf",
      "puppet://$server/modules/site-freeradius/radiusd.conf",
      "puppet://$server/modules/freeradius/radiusd.conf",
    ],
    notify => Service['radiusd'],
    require => Package['freeradius2'],
    owner => root, group => root, mode => 0640;
  }
  file{'/etc/raddb/clients.conf':
    source => [
      "puppet://$server/modules/site-freeradius/$fqdn/clients.conf",
      "puppet://$server/modules/site-freeradius/clients.conf",
      "puppet://$server/modules/freeradius/clients.conf",
    ],
    notify => Service['radiusd'],
    require => Package['freeradius2'],
    owner => root, group => root, mode => 0640;
  }
}
