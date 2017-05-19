#
class storm (
  $version         = $::storm::params::version,
  $download_url    = $::storm::params::download_url,
  $checksum_url    = $::storm::params::checksum_url,
  $manage_group    = $::storm::params::manage_group,
  $storm_group     = $::storm::params::storm_group,
  $manage_user     = $::storm::params::manage_user,
  $storm_user      = $::storm::params::storm_user,
  $manage_home     = $::storm::params::manage_home,
  $user_home       = $::storm::params::user_home,
  $manage_config   = $::storm::params::manage_config,
  $config_template = $::storm::params::config_template,
  $config_options  = $::storm::params::config_options,
  $log4j_cluster_template = $::storm::params::log4j_cluster_template,
  $log4j_cluster_options  = $::storm::params::log4j_cluster_options,
  $log4j_worker_template  = $::storm::params::log4j_worker_template,
  $log4j_worker_options   = $::storm::params::log4j_worker_options,
) inherits ::storm::params {

  $config_options_final = hiera_hash('storm::config_options', $config_options)
  $log4j_cluster_options_final = hiera_hash('storm::log4j_cluster_options', $log4j_cluster_options)
  $log4j_worker_options_final = hiera_hash('storm::log4j_worker_options', $log4j_worker_options)

  include ::storm::install
  include ::storm::config

  Class['::storm::install'] -> Class['::storm::config']

}
