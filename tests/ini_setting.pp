ini_setting { "sample setting":
  path    => '/tmp/foo.ini',
  section => 'foo',
  setting => 'foosetting',
  value   => 'FOO!',
  ensure  => present,
}

ini_setting { "sample setting2":
  path    => '/tmp/foo.ini',
  section => 'bar',
  setting => 'barsetting',
  value   => 'BAR!',
  ensure  => present,
  require => Ini_setting["sample setting"],
}
