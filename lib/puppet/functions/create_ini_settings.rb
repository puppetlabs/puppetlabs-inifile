# @summary DEPRECATED.  Use the namespaced function [`inifile::create_ini_settings`](#inifilecreate_ini_settings) instead.
Puppet::Functions.create_function(:create_ini_settings) do
  dispatch :deprecation_gen do
    repeated_param 'Any', :args
  end
  def deprecation_gen(*args)
    call_function('deprecation', 'create_ini_settings', 'This method is deprecated, please use inifile::create_ini_settings instead.')
    call_function('inifile::create_ini_settings', *args)
  end
end
