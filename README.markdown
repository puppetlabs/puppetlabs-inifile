# INI-file module #

This module provides resource types for use in managing INI-style configuration
files.  The main resource type is `ini_setting`, which is used to manage an
individual setting in an INI file.  Here's an example usage:

    ini_setting { "sample setting":
      path    => '/tmp/foo.ini',
      section => 'foo',
      setting => 'foosetting',
      value   => 'FOO!',
      ensure  => present,
    }

A supplementary resource type is `ini_subsetting`, which is used to manage
settings that consist of several arguments such as

    JAVA_ARGS="-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof "

    ini_subsetting {'sample subsetting':
      ensure  => present,
      section => '',
      key_val_separator => '=',
      path => '/etc/default/pe-puppetdb',
      setting => 'JAVA_ARGS',
      subsetting => '-Xmx',
      value   => '512m',
    }

A few noteworthy features:

 * The module tries *hard* not to manipulate your file any more than it needs to.
   In most cases, it should leave the original whitespace, comments, ordering,
   etc. perfectly intact.
 * Supports comments starting with either '#' or ';'.
 * Will add missing sections if they don't exist.
 * Supports a "global" section (settings that go at the beginning of the file,
   before any named sections) by specifying a section name of "".

