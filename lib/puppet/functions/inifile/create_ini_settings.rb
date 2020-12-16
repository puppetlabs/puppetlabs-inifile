# frozen_string_literal: true

# @summary This function is used to create a set of ini_setting resources from a hash
Puppet::Functions.create_function(:'inifile::create_ini_settings') do
  # @param settings
  #   A hash of settings you want to create ini_setting resources from
  # @param defaults
  #   A hash of defaults you would like to use in the ini_setting resources
  dispatch :default_impl do
    param 'Hash', :settings
    optional_param 'Hash', :defaults
  end

  def default_impl(settings, defaults = {})
    resources = settings.keys.each_with_object({}) do |section, res|
      unless settings[section].is_a?(Hash)
        raise(Puppet::ParseError,
              _('create_ini_settings(): Section %{section} must contain a Hash') % { section: section })
      end

      path = defaults.merge(settings)['path']
      raise Puppet::ParseError, _('create_ini_settings(): must pass the path parameter to the Ini_setting resource!') unless path

      settings[section].each do |setting, value|
        res["#{path} [#{section}] #{setting}"] = {
          'ensure'  => 'present',
          'section' => section,
          'setting' => setting,
        }.merge(if value.is_a?(Hash)
                  value
                else
                  { 'value' => value }
                end)
      end
    end

    call_function('create_resources', 'ini_setting', resources, defaults)
  end
end
