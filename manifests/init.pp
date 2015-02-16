# == Class: inifile
#
# Use create_resources() to allow the specification of ini_setting and
# ini_subsetting entries.
#
class inifile (
  $ini_settings                = undef,
  $ini_subsettings             = undef,
  $ini_settings_hiera_merge    = true,
  $ini_subsettings_hiera_merge = true,
) {

  if is_string($ini_settings_hiera_merge) == true {
    $ini_settings_hiera_merge_bool = str2bool($ini_settings_hiera_merge)
  } else {
    $ini_settings_hiera_merge_bool = $ini_settings_hiera_merge
  }
  validate_bool($ini_settings_hiera_merge_bool)

  if is_string($ini_subsettings_hiera_merge) == true {
    $ini_subsettings_hiera_merge_bool = str2bool($ini_subsettings_hiera_merge)
  } else {
    $ini_subsettings_hiera_merge_bool = $ini_subsettings_hiera_merge
  }
  validate_bool($ini_subsettings_hiera_merge_bool)

  if $ini_settings != undef {
    if $ini_settings_hiera_merge_bool == true {
      $ini_settings_real = hiera_hash('inifile::ini_settings')
    } else {
      $ini_settings_real = $ini_settings
    }
    validate_hash($ini_settings_real)
    create_resources('ini_setting',$ini_settings_real)
  }

  if $ini_subsettings != undef {
    if $ini_subsettings_hiera_merge_bool == true {
      $ini_subsettings_real = hiera_hash('inifile::ini_subsettings')
    } else {
      $ini_subsettings_real = $ini_subsettings
    }
    validate_hash($ini_subsettings_real)
    create_resources('ini_subsetting',$ini_subsettings_real)
  }
}
