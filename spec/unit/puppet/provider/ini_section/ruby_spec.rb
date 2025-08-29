# frozen_string_literal: true

require 'spec_helper'
require 'puppet'

provider_class = Puppet::Type.type(:ini_section).provider(:ruby)
describe provider_class do
  include PuppetlabsSpec::Files

  let(:tmpfile) { tmpfilename('ini_section_test') }
  let(:emptyfile) { tmpfilename('ini_section_test_empty') }

  let(:common_params) do
    {
      title: 'ini_section_ensure_present_test',
      path: tmpfile,
    }
  end

  def validate_file(expected_content, tmpfile)
    expect(File.read(tmpfile)).to eq(expected_content)
  end

  before :each do
    File.write(tmpfile, orig_content)
    File.write(emptyfile, '')
  end

  context 'when calling instances' do
    let :orig_content do
      ''
    end

    it 'fails when file path is not set' do
      expect {
        provider_class.instances
      }.to raise_error(Puppet::Error, 'Ini_section only support collecting instances when a file path is hard coded')
    end

    context 'when file path is set by a child class' do
      child_one = Class.new(provider_class) do
        def self.file_path
          emptyfile
        end
      end
      it 'returns [] when file is empty' do
        allow(child_one).to receive(:file_path).and_return(emptyfile)
        expect(child_one.instances).to eq([])
      end

      child_two = Class.new(provider_class) do
        def self.file_path
          '/some/file/path'
        end
      end
      it 'overrides the provider instances file_path' do
        resource = Puppet::Type::Ini_section.new(common_params)
        provider = child_two.new(resource)
        expect(provider.file_path).to eq('/some/file/path')
      end
    end

    context 'when file has contents' do
      let(:orig_content) do
        <<-INIFILE
          # This is a comment
          [section1]
          ; This is also a comment
          foo=foovalue

          bar = barvalue
          main = true
          [section2]

          foo= foovalue2
          baz=bazvalue
          url = http://192.168.1.1:8080
          [section:sub]
          subby=bar
              #another comment
           ; yet another comment
        INIFILE
      end

      it 'is able to parse the results' do
        child_three = Class.new(provider_class) do
          def self.file_path
            '/some/file/path'
          end
        end
        expect(child_three).to receive(:file_path).twice.and_return(tmpfile)
        expect(child_three.instances.size).to eq(3)
        expected_array = [
          { name: 'section1' },
          { name: 'section2' },
          { name: 'section:sub' },
        ]
        real_array = []
        ensure_array = []
        child_three.instances.each do |x|
          prop_hash    = x.instance_variable_get(:@property_hash)
          ensure_value = prop_hash.delete(:ensure)
          ensure_array.push(ensure_value)
          real_array.push(prop_hash)
        end
        expect(ensure_array.uniq).to eq([:present])
        expect((real_array - expected_array) && (expected_array - real_array)).to eq([])
      end
    end
  end

  context 'when ensuring that a section is present' do
    let(:orig_content) do
      <<~INIFILE
        # This is a comment
        [section1]
        ; This is also a comment
        foo=foovalue

        bar = barvalue
        main = true
        [section2]

        foo= foovalue2
        baz=bazvalue
        url = http://192.168.1.1:8080
        [section:sub]
        subby=bar
            #another comment
         ; yet another comment

        -nonstandard-
          shoes = purple
      INIFILE
    end

    expected_content_one = <<~INIFILE
      # This is a comment
      [section1]
      ; This is also a comment
      foo=foovalue

      bar = barvalue
      main = true
      [section2]

      foo= foovalue2
      baz=bazvalue
      url = http://192.168.1.1:8080
      [section:sub]
      subby=bar
          #another comment
       ; yet another comment

      -nonstandard-
        shoes = purple

      [yippee]
    INIFILE
    it 'adds a missing section' do
      resource = Puppet::Type::Ini_section.new(common_params.merge(section: 'yippee'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be false
      provider.create
      validate_file(expected_content_one, tmpfile)
    end

    expected_content_two = <<~INIFILE
      # This is a comment
      [section1]
      ; This is also a comment
      foo=foovalue

      bar = barvalue
      main = true
      [section2]

      foo= foovalue2
      baz=bazvalue
      url = http://192.168.1.1:8080
      [section:sub]
      subby=bar
          #another comment
       ; yet another comment

      -nonstandard-
        shoes = purple
    INIFILE
    it 'does nothing when the section is already there' do
      resource = Puppet::Type::Ini_section.new(common_params.merge(section: 'section2'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be true
      provider.create
      validate_file(expected_content_two, tmpfile)
    end

    it 'does nothing when the section with custom prefix/suffix is already there' do
      resource = Puppet::Type::Ini_section.new(common_params.merge(section: 'nonstandard', section_prefix: '-', section_suffix: '-'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be true
      provider.create
      validate_file(expected_content_two, tmpfile)
    end
  end

  context 'when ensuring that a section is absent' do
    let(:orig_content) do
      <<~INIFILE
        # This is a comment
        [section1]
        ; This is also a comment
        foo=foovalue

        bar = barvalue
        main = true
        [section2]

        foo= foovalue2
        baz=bazvalue
        url = http://192.168.1.1:8080
        [section:sub]
        subby=bar
            #another comment
         ; yet another comment

        -nonstandard-
          shoes = purple
      INIFILE
    end

    expected_content_one = <<~INIFILE
      # This is a comment
      [section1]
      ; This is also a comment
      foo=foovalue

      bar = barvalue
      main = true
      [section:sub]
      subby=bar
          #another comment
       ; yet another comment

      -nonstandard-
        shoes = purple
    INIFILE
    it 'removes an existing section' do
      resource = Puppet::Type::Ini_section.new(common_params.merge(section: 'section2'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be true
      provider.destroy
      validate_file(expected_content_one, tmpfile)
    end

    expected_content_two = <<~INIFILE
      # This is a comment
      [section1]
      ; This is also a comment
      foo=foovalue

      bar = barvalue
      main = true
      [section2]

      foo= foovalue2
      baz=bazvalue
      url = http://192.168.1.1:8080
      [section:sub]
      subby=bar
          #another comment
       ; yet another comment

    INIFILE
    it 'removes an existing section with custom prefix/suffix' do
      resource = Puppet::Type::Ini_section.new(common_params.merge(section: 'nonstandard', section_prefix: '-', section_suffix: '-'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be true
      provider.destroy
      validate_file(expected_content_two, tmpfile)
    end

    it 'does nothing when the section does not exist' do
      resource = Puppet::Type::Ini_section.new(common_params.merge(section: 'yippee'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be false
      provider.destroy
      validate_file(orig_content, tmpfile)
    end
  end
end
