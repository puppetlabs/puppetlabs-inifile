# Manifest creating multiple ini_settings
class create_multiple_ini_settings {
  if $facts['os']['family'] == 'windows' {
    $defaults = { 'path' => 'C:/tmp/foo.ini' }
  } else {
    $defaults = { 'path' => '/tmp/foo.ini' }
  }

  $example = {
    'section1' => {
      'setting1'  => 'value1',
      'setting2' => {
        'ensure' => 'absent',
      },
    },
  }

  inifile::create_ini_settings($example, $defaults)
}
