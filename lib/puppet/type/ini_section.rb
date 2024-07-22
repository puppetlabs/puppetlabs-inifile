# frozen_string_literal: true

Puppet::Type.newtype(:ini_section) do
  desc 'ini_section is used to manage a single section in an INI file'
  ensurable do
    desc 'Ensurable method handles modeling creation. It creates an ensure property'
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
    def insync?(current)
      if @resource[:refreshonly]
        true
      else
        current == should
      end
    end
    defaultto :present
  end

  newparam(:name, namevar: true) do
    desc 'An arbitrary name used as the identity of the resource.'
  end

  newparam(:section) do
    desc 'The name of the section in the ini file which should be managed.'
    defaultto('')
  end

  newparam(:path) do
    desc 'The ini file Puppet will ensure contains the specified section.'
    validate do |value|
      raise(Puppet::Error, _("File paths must be fully qualified, not '%{value}'") % { value: value }) unless Puppet::Util.absolute_path?(value)
    end
  end

  newparam(:section_prefix) do
    desc 'The prefix to the section name\'s header.'
    defaultto('[')
  end

  newparam(:section_suffix) do
    desc 'The suffix to the section name\'s header.'
    defaultto(']')
  end

  autorequire(:file) do
    Pathname.new(self[:path]).parent.to_s
  end
end
