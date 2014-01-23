# == Class: inifile
#
# Use create_resources() to allow the specification of ini_setting and
# ini_subsetting entries.
#
class inifile (
  $hiera_merge     = true,
  $ini_settings    = undef,
  $ini_subsettings = undef,
) {

  if type($hiera_merge) == 'String' {
    $hiera_merge_bool = str2bool($hiera_merge)
  } else {
    $hiera_merge_bool = $hiera_merge
  }
  validate_bool($hiera_merge)

  if $ini_settings != undef {
    if $hiera_merge == true {
      $ini_settings_real = hiera_hash('ssh::ini_settings')
    } else {
      $ini_settings_real = $ini_settings
    }
    validate_hash($ini_settings)
    create_resources('ini_setting',$ini_settings_real)
  }

  if $ini_subsettings != undef {
    if $hiera_merge == true {
      $ini_subsettings_real = hiera_hash('ssh::ini_subsettings')
    } else {
      $ini_subsettings_real = $ini_subsettings
    }
    validate_hash($ini_subsettings)
    create_resources('ini_subsetting',$ini_subsettings_real)
  }
}
