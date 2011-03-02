class freeradius::ldap {
  include freeradius
  package{'freeradius2-ldap':
    ensure => 'present',
  }
}
