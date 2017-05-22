#
class storm::config inherits ::storm {

  if $::storm::manage_config {
    file { $::storm::config_options_final['storm.local.dir'] :
      ensure => directory,
      owner  => $::storm::storm_user,
      group  => $::storm::storm_group,
      mode   => '0750',
    }

    file { "${::storm::user_home}/apache-storm-${::storm::version}/conf/storm.yaml":
      ensure  => file,
      owner   => $::storm::storm_user,
      group   => $::storm::storm_group,
      mode    => '0444',
      content => template($::storm::config_template),
    }

    file { "${::storm::user_home}/apache-storm-${::storm::version}/log4j2/cluster.xml":
      ensure  => file,
      owner   => $::storm::storm_user,
      group   => $::storm::storm_group,
      mode    => '0444',
      content => template($::storm::log4j_cluster_template),
    }

    file { "${::storm::user_home}/apache-storm-${::storm::version}/log4j2/worker.xml":
      ensure  => file,
      owner   => $::storm::storm_user,
      group   => $::storm::storm_group,
      mode    => '0444',
      content => template($::storm::log4j_worker_template),
    }
  }

}
