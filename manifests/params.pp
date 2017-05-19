#
class storm::params {

  $version      = '1.1.0'
  $download_url = 'http://mirrors.ocf.berkeley.edu/apache'
  $checksum_url = 'http://apache.org/dist'

  $manage_group = true
  $storm_group  = 'storm'
  $manage_user  = true
  $storm_user   = 'storm'
  $manage_home  = true
  $user_home    = '/opt/storm'

  $manage_config = true
  $config_template = 'storm/storm.yaml.erb'
  $config_options = {
    'storm.local.dir' => '/var/lib/storm',
  }
  $log4j_cluster_template = 'storm/log4j2.cluster.xml.erb'
  $log4j_cluster_options = {}
  $log4j_worker_template = 'storm/log4j2.worker.xml.erb'
  $log4j_worker_options = {}

}
