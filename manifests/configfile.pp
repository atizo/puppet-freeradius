define freeradius::configfile {
  file{"/etc/raddb/$name":
    source => [
      "puppet://$server/modules/site-freeradius/$fqdn/$name",
      "puppet://$server/modules/site-freeradius/$name",
      "puppet://$server/modules/freeradius/$name",
    ],
    notify => Service['radiusd'],
    require => Package['freeradius2'],
    owner => root, group => root, mode => 0640;
  }
}
