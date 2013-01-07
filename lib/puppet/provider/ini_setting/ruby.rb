require File.expand_path('../../../util/ini_file', __FILE__)

Puppet::Type.type(:ini_setting).provide(:ruby) do

  def self.instances
    if self.respond_to?(:file_path)
      # figure out what to do about the seperator
      ini_file  = Puppet::Util::IniFile.new(file_path, '=')
      resources = []
      ini_file.section_names.each do |section_name|
        ini_file.get_settings(section_name).each do |setting, value|
          resources.push(
            new(
              :name   => "#{section_name}/#{setting}",
              :value  => value,
              :ensure => :present
            )
          )
        end
      end
      resources
    else
      raise(Puppet::Error, 'Ini_settings only support collecting instances when a file path is hard coded')
    end
  end

  def exists?
    ini_file.get_value(section, setting)
  end

  def create
    ini_file.set_value(section, setting, resource[:value])
    ini_file.save
    @ini_file = nil
  end

  def destroy
    ini_file.remove_setting(section, setting)
    ini_file.save
    @ini_file = nil
  end

  def value
    ini_file.get_value(section, setting)
  end

  def value=(value)
    ini_file.set_value(section, setting, resource[:value])
    ini_file.save
  end

  def section
    resource[:section]
  end

  def setting
    resource[:setting]
  end

  def file_path
    if self.class.respond_to?(:file_path)
      self.class.file_path
    else
      resource[:path]
    end
  end

  def separator
    resource[:key_val_separator] || '='
  end

  private
  def ini_file
    @ini_file ||= Puppet::Util::IniFile.new(file_path, separator)
  end

end
