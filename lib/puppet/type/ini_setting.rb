require File.expand_path('../../util/ini_file', __FILE__)

Puppet::Type.newtype(:ini_setting) do

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc 'An arbitrary name used as the identity of the resource.'
  end

  newparam(:section) do
    desc 'The name of the section in the ini file in which the setting should be defined.'
  end

  newparam(:setting) do
    desc 'The name of the setting to be defined.'
  end

  newparam(:path) do
    desc 'The ini file Puppet will ensure contains the specified setting.'
    validate do |value|
      unless (Puppet.features.posix? and value =~ /^\//) or (Puppet.features.microsoft_windows? and (value =~ /^.:\// or value =~ /^\/\/[^\/]+\/[^\/]+/))
        raise(Puppet::Error, "File paths must be fully qualified, not '#{value}'")
      end
    end
  end

  newparam(:source) do
    desc 'The ini file to read sections/settings/values from.'
    defaultto([])

    validate do |sources|
      sources = [sources] unless sources.is_a?(Array)
      sources.each do |source|
        next if Puppet::Util.absolute_path?(source)
        begin
          uri = URI.parse(URI.escape(source))
        rescue => detail
          self.fail "Could not understand source #{source}: #{detail}"
        end
        self.fail "Cannot use relative URLs '#{source}'" unless uri.absolute?
        self.fail "Cannot use opaque URLs '#{source}'" unless uri.hierarchical?
        self.fail "Cannot use URLs of type '#{uri.scheme}' for grabbing the source .ini" unless %w{file puppet}.include?(uri.scheme)
      end
    end

    SEPARATOR_REGEX = [Regexp.escape(File::SEPARATOR.to_s), Regexp.escape(File::ALT_SEPARATOR.to_s)].join
    munge do |sources|
      sources = [sources] unless sources.is_a?(Array)
      sources.map do |source|
        source = source.sub(/[#{SEPARATOR_REGEX}]+$/, '')
        if Puppet::Util.absolute_path?(source)
          URI.unescape(Puppet::Util.path_to_uri(source).to_s)
        else
          source
        end
      end
    end
  end

  newparam(:key_val_separator) do
    desc 'The separator string to use between each setting name and value. ' +
        'Defaults to " = ", but you could use this to override e.g. whether ' +
        'or not the separator should include whitespace.'
    defaultto(" = ")

    validate do |value|
      unless value.scan('=').size == 1
        raise Puppet::Error, ":key_val_separator must contain exactly one = character."
      end
    end
  end

  newproperty(:value) do
    desc 'The value of the setting to be defined.'
  end

  def eval_generate
    return [] if self[:source].empty?
    content = nil
    self[:source].each do |source|
      if tmp = indirection_get_ini_file(source)
        content = tmp.content
        break
      end
    end
    fail 'Could not find any valid source URLs' unless content
    source_ini = Puppet::Util::IniFile.new(content, self[:key_val_separator], false)
    children = []
    title = self[:name]
    source_ini.section_names.each do |section|
      source_ini.section_settings(section).each do |setting|
        options = @original_parameters.merge(
          :source  => [],
          :section => section,
          :setting => setting,
          :value   => source_ini.get_value(section, setting),
          :name    => title + ' @ [' + section + ']: ' + setting
        ).reject { |param, value| value.nil? }
        children << self.class.new(options)
      end
    end
    children
  end

  # Having it as its own method makes testing easier
  def indirection_get_ini_file(source)
    Puppet::FileServing::Content.indirection.find(source, :environment => self.catalog.environment)
  end

end
