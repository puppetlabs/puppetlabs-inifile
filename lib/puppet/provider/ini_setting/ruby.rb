require 'puppet/util/ini_file'

Puppet::Type.type(:ini_setting).provide(:ruby) do
  def exists?
    ini_file.get_value(resource[:section], resource[:setting]) == resource[:value]
  end

  def create
    ini_file.set_value(resource[:section], resource[:setting], resource[:value])
    ini_file.save
    @ini_file = nil
  end


  private
  def ini_file
    @ini_file ||= Puppet::Util::IniFile.new(resource[:path])
  end
end
