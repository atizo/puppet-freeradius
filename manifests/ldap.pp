class freeradius::ldap {
  include freeradius
  package{'freeradius2-ldap':
    ensure => 'present',
  }
  freeradius::configfile{'modules/ldap':
    require => Package['freeradius2-ldap'],
  }
}
