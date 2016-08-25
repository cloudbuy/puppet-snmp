# == Class: snmp::params
#
# This class handles OS-specific configuration of the snmp module.  It
# looks for variables in top scope (probably from an ENC such as Dashboard).  If
# the variable doesn't exist in top scope, it falls back to a hard coded default
# value.
#
# === Authors:
#
# Mike Arnold <mike@razorsedge.org>
#
# === Copyright:
#
# Copyright (C) 2012 Mike Arnold, unless otherwise noted.
#
class snmp::params {
  # If we have a top scope variable defined, use it, otherwise fall back to a
  # hardcoded value.
  $agentaddress = defined('$::snmp_agentaddress') ? {
    false   => [ 'udp:127.0.0.1:161', 'udp6:[::1]:161' ],
    default => $::snmp_agentaddress,
  }

  $snmptrapdaddr = defined('$::snmp_snmptrapdaddr') ? {
    false   => [ 'udp:127.0.0.1:162', 'udp6:[::1]:162' ],
    default => $::snmp_snmptrapdaddr,
  }

  $ro_community = defined('$::snmp_ro_community') ? {
    false   => 'public',
    default => $::snmp_ro_community,
  }

  $ro_community6 = defined('$::snmp_ro_community6') ? {
    false   => 'public',
    default => $::snmp_ro_community6,
  }

  $rw_community = defined('$::snmp_rw_community') ? {
    false   => undef,
    default => $::snmp_rw_community,
  }

  $rw_community6 = defined('$::snmp_rw_community6') ? {
    false   => undef,
    default => $::snmp_rw_community6,
  }

  $ro_network = defined('$::snmp_ro_network') ? {
    false   => '127.0.0.1',
    default => $::snmp_ro_network,
  }

  $ro_network6 = defined('$::snmp_ro_network6') ? {
    false   => '::1',
    default => $::snmp_ro_network6,
  }

  $rw_network = defined('$::snmp_rw_network') ? {
    false   => '127.0.0.1',
    default => $::snmp_rw_network,
  }

  $rw_network6 = defined('$::snmp_rw_network6') ? {
    false   => '::1',
    default => $::snmp_rw_network6,
  }

  $contact = defined('$::snmp_contact') ? {
    false   => 'Unknown',
    default => $::snmp_contact,
  }

  $location = defined('$::snmp_location') ? {
    false   => 'Unknown',
    default => $::snmp_location,
  }

  $sysname = defined('$::snmp_sysname') ? {
    false   => $::fqdn,
    default => $::snmp_sysname,
  }

  $com2sec = defined('$::snmp_com2sec') ? {
    false   => [
      "notConfigUser  default       public",
    ],
    default => $::snmp_com2sec,
  }

  $com2sec6 = defined('$::snmp_com2sec6') ? {
    false   => [
      "notConfigUser  default       public",
    ],
    default => $::snmp_com2sec6,
  }

  $groups = defined('$::snmp_groups') ? {
    false   => [
      'notConfigGroup v1            notConfigUser',
      'notConfigGroup v2c           notConfigUser',
    ],
    default => $::snmp_groups,
  }

  $services = defined('$::snmp_services') ? {
    false   => 72,
    default => $::snmp_services,
  }

  $openmanage_enable = defined('$::openmanage_enable') ? {
    false   => false,
    default => $::openmanage_enable
  }

  $views = defined('$::snmp_views') ? {
    false   => [
      'systemview    included   .1.3.6.1.2.1.1',
      'systemview    included   .1.3.6.1.2.1.25.1.1',
    ],
    default => $::snmp_views,
  }

  $accesses = defined('$::snmp_accesses') ? {
    false   => [
      'notConfigGroup ""      any       noauth    exact  systemview none  none',
    ],
    default => $::snmp_accesses,
  }

  $dlmod = defined('$::snmp_dlmod') ? {
    false   => [],
    default => $::snmp_dlmod,
  }

  $disable_authorization = defined('$::snmp_disable_authorization') ? {
    false   => 'no',
    default => $::snmp_disable_authorization,
  }

  $do_not_log_traps = defined('$::snmp_do_not_log_traps') ? {
    false   => 'no',
    default => $::snmp_do_not_log_traps,
  }

  $do_not_log_tcpwrappers = defined('$::snmp_do_not_log_tcpwrappers') ? {
    false   => 'no',
    default => $::snmp_do_not_log_tcpwrappers,
  }

  $trap_handlers = defined('$::snmp_trap_handlers') ? {
    false   => [],
    default => $::snmp_trap_handlers,
  }

  $trap_forwards = defined('$::snmp_trap_forwards') ? {
    false   => [],
    default => $::snmp_trap_forwards,
  }

  $snmp_config = defined('$::snmp_snmp_config') ? {
    false   => [],
    default => $::snmp_snmp_config,
  }

  $snmpd_config = defined('$::snmp_snmpd_config') ? {
    false   => [],
    default => $::snmp_snmpd_config,
  }

  $snmptrapd_config = defined('$::snmp_snmptrapd_config') ? {
    false   => [],
    default => $::snmp_snmptrapd_config,
  }

### The following parameters should not need to be changed.

  $ensure = defined('$::snmp_ensure') ? {
    false   => 'present',
    default => $::snmp_ensure,
  }

  $service_ensure = defined('$::snmp_service_ensure') ? {
    false   => 'running',
    default => $::snmp_service_ensure,
  }

  $trap_service_ensure = defined('$::snmp_trap_service_ensure') ? {
    false   => 'stopped',
    default => $::snmp_trap_service_ensure,
  }

  # Since the top scope variable could be a string (if from an ENC), we might
  # need to convert it to a boolean.
  $autoupgrade = defined('$::snmp_autoupgrade') ? {
    false   => false,
    default => $::snmp_autoupgrade,
  }
  if is_string($autoupgrade) {
    $safe_autoupgrade = str2bool($autoupgrade)
  } else {
    $safe_autoupgrade = $autoupgrade
  }

  $install_client = defined('$::snmp_install_client') ? {
    false   => undef,
    default => $::snmp_install_client,
  }

  $manage_client = defined('$::snmp_manage_client') ? {
    false   => false,
    default => $::snmp_manage_client,
  }
  if is_string($manage_client) {
    $safe_manage_client = str2bool($manage_client)
  } else {
    $safe_manage_client = $manage_client
  }

  $service_enable = defined('$::snmp_service_enable') ? {
    false   => true,
    default => $::snmp_service_enable,
  }
  if is_string($service_enable) {
    $safe_service_enable = str2bool($service_enable)
  } else {
    $safe_service_enable = $service_enable
  }

  $service_hasstatus = defined('$::snmp_service_hasstatus') ? {
    false   => true,
    default => $::snmp_service_hasstatus,
  }
  if is_string($service_hasstatus) {
    $safe_service_hasstatus = str2bool($service_hasstatus)
  } else {
    $safe_service_hasstatus = $service_hasstatus
  }

  $service_hasrestart = defined('$::snmp_service_hasrestart') ? {
    false   => true,
    default => $::snmp_service_hasrestart,
  }
  if is_string($service_hasrestart) {
    $safe_service_hasrestart = str2bool($service_hasrestart)
  } else {
    $safe_service_hasrestart = $service_hasrestart
  }

  $trap_service_enable = defined('$::snmp_trap_service_enable') ? {
    false   => false,
    default => $::snmp_trap_service_enable,
  }
  if is_string($trap_service_enable) {
    $safe_trap_service_enable = str2bool($trap_service_enable)
  } else {
    $safe_trap_service_enable = $trap_service_enable
  }

  $trap_service_hasstatus = defined('$::snmp_trap_service_hasstatus') ? {
    false   => true,
    default => $::snmp_trap_service_hasstatus,
  }
  if is_string($trap_service_hasstatus) {
    $safe_trap_service_hasstatus = str2bool($trap_service_hasstatus)
  } else {
    $safe_trap_service_hasstatus = $trap_service_hasstatus
  }

  $trap_service_hasrestart = defined('$::snmp_trap_service_hasrestart') ? {
    false   => true,
    default => $::snmp_trap_service_hasrestart,
  }
  if is_string($trap_service_hasrestart) {
    $safe_trap_service_hasrestart = str2bool($trap_service_hasrestart)
  } else {
    $safe_trap_service_hasrestart = $trap_service_hasrestart
  }

  case $::osfamily {
    'RedHat': {
      if $::operatingsystemmajrelease { # facter 1.7+
        $majdistrelease = $::operatingsystemmajrelease
      } elsif $::lsbmajdistrelease {    # requires LSB to already be installed
        $majdistrelease = $::lsbmajdistrelease
      } else {
        $majdistrelease = regsubst($::operatingsystemrelease,'^(\d+)\.(\d+)','\1')
      }
      case $::operatingsystem {
        'Fedora': {
          $snmpd_options     = '-LS0-6d'
          $snmptrapd_options = '-Lsd'
          $sysconfig         = '/etc/sysconfig/snmpd'
          $trap_sysconfig    = '/etc/sysconfig/snmptrapd'
          $var_net_snmp      = '/var/lib/net-snmp'
          $varnetsnmp_perms  = '0755'
        }
        default: {
          if $majdistrelease <= '5' {
            $snmpd_options     = '-Lsd -Lf /dev/null -p /var/run/snmpd.pid -a'
            $sysconfig         = '/etc/sysconfig/snmpd.options'
            $trap_sysconfig    = '/etc/sysconfig/snmptrapd.options'
            $var_net_snmp      = '/var/net-snmp'
            $varnetsnmp_perms  = '0700'
            $snmptrapd_options = '-Lsd -p /var/run/snmptrapd.pid'
          } elsif $majdistrelease == '6' {
            $snmpd_options     = '-LS0-6d -Lf /dev/null -p /var/run/snmpd.pid'
            $sysconfig         = '/etc/sysconfig/snmpd'
            $trap_sysconfig    = '/etc/sysconfig/snmptrapd'
            $var_net_snmp      = '/var/lib/net-snmp'
            $varnetsnmp_perms  = '0755'
            $snmptrapd_options = '-Lsd -p /var/run/snmptrapd.pid'
          } else {
            $snmpd_options     = '-LS0-6d'
            $sysconfig         = '/etc/sysconfig/snmpd'
            $trap_sysconfig    = '/etc/sysconfig/snmptrapd'
            $var_net_snmp      = '/var/lib/net-snmp'
            $varnetsnmp_perms  = '0755'
            $snmptrapd_options = '-Lsd'
          }
        }
      }
      $package_name             = 'net-snmp'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0644'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $varnetsnmp_owner         = 'root'
      $varnetsnmp_group         = 'root'

      $client_package_name      = 'net-snmp-utils'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
    }
    'Debian': {
      $package_name             = 'snmpd'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0600'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $snmpd_options            = '-Lsd -Lf /dev/null -u snmp -g snmp -I -smux -p /var/run/snmpd.pid'
      $sysconfig                = '/etc/default/snmpd'
      $var_net_snmp             = '/var/lib/snmp'
      $varnetsnmp_perms         = '0755'
      $varnetsnmp_owner         = 'snmp'
      $varnetsnmp_group         = 'snmp'

      $client_package_name      = 'snmp'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $snmptrapd_options        = '-Lsd -p /var/run/snmptrapd.pid'
    }
    'Suse': {
      $package_name             = 'net-snmp'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0600'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $snmpd_options            = 'd'
      $sysconfig                = '/etc/sysconfig/net-snmp'
      $var_net_snmp             = '/var/lib/net-snmp'
      $varnetsnmp_perms         = '0755'
      $varnetsnmp_owner         = 'root'
      $varnetsnmp_group         = 'root'

      $client_package_name      = 'net-snmp'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
      $snmptrapd_options        = undef
    }
    'FreeBSD': {
      $package_name             = 'net-mgmt/net-snmp'
      $service_config_dir_path  = '/usr/local/etc/snmp'
      $service_config_dir_perms = '0755'
      $service_config_dir_owner = 'root'
      $service_config_dir_group = 'wheel'
      $service_config           = '/usr/local/etc/snmp/snmpd.conf'
      $service_config_perms     = '0755'
      $service_name             = 'snmpd'
      $snmpd_options            = 'd'
      $var_net_snmp             = '/var/net-snmp'
      $varnetsnmp_perms         = '0600'
      $varnetsnmp_owner         = 'root'
      $varnetsnmp_group         = 'wheel'

      $client_package_name      = 'net-mgmt/net-snmp'
      $client_config            = '/usr/local/etc/snmp/snmp.conf'

      $trap_service_config      = '/usr/local/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
      $snmptrapd_options        = undef
    }
    default: {
      fail("Module ${::module} is not supported on ${::operatingsystem}")
    }
  }
}
