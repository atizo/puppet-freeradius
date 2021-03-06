#
# freeradius module
#
# Copyright 2011, Atizo AG
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
    require => [
      Package['freeradius2'],
      Exec['freeradius-certificates'],
    ],
  }
  exec{'freeradius-certificates':
    command => 'make -C /etc/raddb/certs',
    creates => '/etc/raddb/certs/server.crt',
    require => Package['freeradius2'],
  }
  freeradius::configfile{[
    'radiusd.conf',
    'clients.conf',
    'eap.conf',
    'sites-available/default',
    'sites-available/inner-tunnel',
  ]:}
}
