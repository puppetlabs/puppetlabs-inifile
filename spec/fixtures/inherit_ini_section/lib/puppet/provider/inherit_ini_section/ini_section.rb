Puppet::Type.type(:inherit_ini_section).provide(
  :ini_section,
  parent: Puppet::Type.type(:ini_section).provider(:ruby),
) do
  def self.namevar(section)
    section
  end

  def self.file_path
    File.expand_path(File.dirname(__FILE__) + '/../../../../../../tmp/inherit_inifile.cfg')
  end
end
