Puppet::Type.type(:inherit_ini_setting).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:ini_setting).provider(:ruby)
) do
  def section
    '' # all global
  end
  def self.file_path
    File.expand_path(File.dirname(__FILE__) + '/../../../../../../tmp/inherit_inifile.cfg')
  end
end
