#
class storm::install inherits ::storm {

  if $::storm::manage_group {
    group { $::storm::storm_group :
      ensure => present,
    }
  }

  if $::storm::manage_user {
    user { $::storm::storm_user :
      ensure     => present,
      comment    => 'Storm User',
      gid        => $::storm::storm_group,
      home       => $::storm::user_home,
      managehome => $::storm::manage_home,
      system     => true,
    }
  }

  archive { "apache-storm-${::storm::version}.tar.gz":
    path          => "${::storm::user_home}/apache-storm-${::storm::version}.tar.gz",
    source        => "${::storm::download_url}/storm/apache-storm-${::storm::version}/apache-storm-${::storm::version}.tar.gz",
    #checksum_url  => "${::storm::checksum_url}/storm/apache-storm-${::storm::version}/apache-storm-${::storm::version}.tar.gz.sha",
    #checksum_type => 'sha512',
    extract       => true,
    extract_path  => $::storm::user_home,
    creates       => "${::storm::user_home}/apache-storm-${::storm::version}",
    user          => $::storm::storm_user,
    group         => $::storm::storm_group,
    cleanup       => false,
  }

  file { "${::storm::user_home}/apache-storm-${::storm::version}":
    ensure  => directory,
    owner   => $::storm::storm_user,
    group   => $::storm::storm_group,
    require => Archive["apache-storm-${::storm::version}.tar.gz"],
  }

  file { "${::storm::user_home}/apache-storm":
    ensure => 'link',
    target => "${::storm::user_home}/apache-storm-${::storm::version}",
  }

  file { '/var/log/storm':
    ensure => directory,
    owner  => $::storm::storm_user,
    group  => $::storm::storm_group,
    mode   => '0755',
  }

  file { "${::storm::user_home}/apache-storm-${::storm::version}/logs":
    ensure => 'link',
    target => '/var/log/storm',
  }

}
