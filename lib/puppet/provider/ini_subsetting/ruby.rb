# frozen_string_literal: true

require File.expand_path('../../util/ini_file', __dir__)
require File.expand_path('../../util/setting_value', __dir__)

Puppet::Type.type(:ini_subsetting).provide(:ruby) do
  desc '
  Creates new ini_subsetting file, a specific config file with a provider that uses
  this as its parent and implements the method
  self.file_path, and that will provide the value for the path to the
  ini file.'
  def exists?
    setting_value.get_subsetting_value(subsetting, resource[:use_exact_match])
  end

  def create
    setting_value.add_subsetting(
      subsetting, resource[:value], resource[:use_exact_match],
      resource[:insert_type], resource[:insert_value]
    )
    ini_file.set_value(section, setting, key_val_separator, setting_value.get_value)
    ini_file.save
    @ini_file = nil
    @setting_value = nil
  end

  def destroy
    setting_value.remove_subsetting(subsetting, resource[:use_exact_match])
    if setting_value.get_value.empty? && resource[:delete_if_empty]
      ini_file.remove_setting(section, setting)
    else
      ini_file.set_value(section, setting, key_val_separator, setting_value.get_value)
    end
    ini_file.save
    @ini_file = nil
    @setting_value = nil
  end

  def value
    setting_value.get_subsetting_value(subsetting)
  end

  def value=(value)
    setting_value.add_subsetting(
      subsetting, value, resource[:use_exact_match],
      resource[:insert_type], resource[:insert_value]
    )
    ini_file.set_value(section, setting, key_val_separator, setting_value.get_value)
    ini_file.save
  end

  def section
    resource[:section]
  end

  def setting
    resource[:setting]
  end

  def subsetting
    resource[:subsetting]
  end

  def subsetting_separator
    resource[:subsetting_separator]
  end

  def file_path
    resource[:path]
  end

  def key_val_separator
    resource[:key_val_separator] || '='
  end

  def subsetting_key_val_separator
    resource[:subsetting_key_val_separator] || ''
  end

  def quote_char
    resource[:quote_char]
  end

  private

  def ini_file
    @ini_file ||= Puppet::Util::IniFile.new(file_path, key_val_separator)
  end

  def setting_value
    @setting_value ||= Puppet::Util::SettingValue.new(
      ini_file.get_value(section, setting),
      subsetting_separator, quote_char, subsetting_key_val_separator
    )
  end
end
