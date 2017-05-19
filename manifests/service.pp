#
define storm::service (
  $service_template = 'storm/storm.systemd.erb',
  $service_options  = {},
  $service_ensure   = 'running',
  $service_enable   = true,
) {

  # Validate service name
  if ! ($name in ['nimbus', 'supervisor', 'drpc', 'logviewer', 'ui']) {
    fail('Invalid daemon type')
  }

  include ::storm

  file { "/etc/systemd/system/storm-${name}.service":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_template),
    notify  => Service["storm-${name}"],
  }

  service { "storm-${name}":
    ensure => $service_ensure,
    enable => $service_enable,
  }

  Class['::storm::config'] ~> Service["storm-${name}"]

}
