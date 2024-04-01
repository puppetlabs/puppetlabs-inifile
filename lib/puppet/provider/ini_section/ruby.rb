# frozen_string_literal: true

require File.expand_path('../../util/ini_file', __dir__)

Puppet::Type.type(:ini_section).provide(:ruby) do
  def self.instances
    desc '
    Creates new ini_section file, a specific config file with a provider that uses
    this as its parent and implements the method
    self.file_path, and that will provide the value for the path to the
    ini file.'
    raise(Puppet::Error, 'Ini_section only support collecting instances when a file path is hard coded') unless respond_to?(:file_path)

    # figure out what to do about the seperator
    ini_file  = Puppet::Util::IniFile.new(file_path, '=')
    resources = []
    ini_file.section_names.each do |section_name|
      next if section_name.empty?
      resources.push(
        new(
          name: namevar(section_name),
          ensure: :present,
        ),
      )
    end
    resources
  end

  def self.namevar(section_name)
    section_name
  end

  def exists?
    ini_file.section_names.include?(section)
  end

  def create
    ini_file.set_value(section)
    ini_file.save
    @ini_file = nil
  end

  def destroy
    ini_file.remove_section(section)
    ini_file.save
    @ini_file = nil
  end

  def file_path
    # this method is here to support purging and sub-classing.
    # if a user creates a type and subclasses our provider and provides a
    # 'file_path' method, then they don't have to specify the
    # path as a parameter for every ini_section declaration.
    # This implementation allows us to support that while still
    # falling back to the parameter value when necessary.
    if self.class.respond_to?(:file_path)
      self.class.file_path
    else
      resource[:path]
    end
  end

  def section
    # this method is here so that it can be overridden by a child provider
    resource[:section]
  end

  def section_prefix
    if resource.class.validattr?(:section_prefix)
      resource[:section_prefix] || '['
    else
      '['
    end
  end

  def section_suffix
    if resource.class.validattr?(:section_suffix)
      resource[:section_suffix] || ']'
    else
      ']'
    end
  end

  private

  def ini_file
    @ini_file ||= Puppet::Util::IniFile.new(file_path, '=', section_prefix, section_suffix, ' ', 2)
  end
end
