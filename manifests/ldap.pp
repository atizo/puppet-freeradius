class freeradius::ldap {
  include freeradius
  package{'freeradius2-ldap':
    ensure => 'present',
  }
  file{'/etc/raddb/modules/ldap':
    source => [
      "puppet://$server/modules/site-freeradius/modules/$fqdn/ldap",
      "puppet://$server/modules/site-freeradius/modules/ldap",
      "puppet://$server/modules/freeradius/modules/ldap",
    ],
    notify => Service['radiusd'],
    require => Package['freeradius2-ldap'],
    owner => root, group => root, 0640;
  }
}
