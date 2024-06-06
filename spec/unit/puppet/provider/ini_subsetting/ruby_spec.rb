# frozen_string_literal: true

require 'spec_helper'
require 'puppet'

provider_class = Puppet::Type.type(:ini_subsetting).provider(:ruby)
describe provider_class do
  include PuppetlabsSpec::Files

  let(:tmpfile) { tmpfilename('ini_setting_test') }

  def validate_file(expected_content, tmpfile)
    expect(File.read(tmpfile)).to eq expected_content
  end

  before :each do
    File.write(tmpfile, orig_content)
  end

  context 'when ensuring that a subsetting is present' do
    let(:common_params) do
      {
        title: 'ini_setting_ensure_present_test',
        path: tmpfile,
        section: '',
        key_val_separator: '=',
        setting: 'JAVA_ARGS'
      }
    end

    let(:orig_content) do
      <<-JAVAARGS
        JAVA_ARGS="-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
      JAVAARGS
    end

    expected_content_one = <<-JAVAARGS
        JAVA_ARGS="-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof -Xms128m"
    JAVAARGS
    it 'adds a missing subsetting' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-Xms', value: '128m'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be_nil
      provider.create
      validate_file(expected_content_one, tmpfile)
    end

    expected_content_two = <<-JAVAARGS
        JAVA_ARGS="-Xms128m -Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
    JAVAARGS
    it 'adds a missing subsetting element at the beginning of the line' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-Xms', value: '128m', insert_type: :start))
      provider = described_class.new(resource)
      expect(provider.exists?).to be_nil
      provider.create
      validate_file(expected_content_two, tmpfile)
    end

    expected_content_three = <<-JAVAARGS
        JAVA_ARGS="-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof -Xms128m"
    JAVAARGS
    it 'adds a missing subsetting element at the end of the line' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-Xms', value: '128m', insert_type: :end))
      provider = described_class.new(resource)
      expect(provider.exists?).to be_nil
      provider.create
      validate_file(expected_content_three, tmpfile)
    end

    expected_content_four = <<-JAVAARGS
        JAVA_ARGS="-Xmx192m -Xms128m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
    JAVAARGS
    it 'adds a missing subsetting element after the given item' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-Xms', value: '128m', insert_type: :after, insert_value: '-Xmx'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be_nil
      provider.create
      validate_file(expected_content_four, tmpfile)
    end

    expected_content_five = <<-JAVAARGS
        JAVA_ARGS="-Xms128m -Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
    JAVAARGS
    it 'adds a missing subsetting element before the given item' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-Xms', value: '128m', insert_type: :before, insert_value: '-Xmx'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be_nil
      provider.create
      validate_file(expected_content_five, tmpfile)
    end

    expected_content_six = <<-JAVAARGS
        JAVA_ARGS="-Xmx192m -Xms128m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
    JAVAARGS
    it 'adds a missing subsetting element at the given index' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-Xms', value: '128m', insert_type: :index, insert_value: '1'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be_nil
      provider.create
      validate_file(expected_content_six, tmpfile)
    end

    expected_content_seven = <<-JAVAARGS
        JAVA_ARGS="-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
    JAVAARGS
    it 'removes an existing subsetting' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-Xmx'))
      provider = described_class.new(resource)
      expect(provider.exists?).to eq '192m'
      provider.destroy
      validate_file(expected_content_seven, tmpfile)
    end

    expected_content_eight = <<-JAVAARGS
        JAVA_ARGS="-Xmx192m"
    JAVAARGS
    it 'is able to remove several subsettings with the same name' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-XX'))
      provider = described_class.new(resource)
      expect(provider.exists?).to eq ':+HeapDumpOnOutOfMemoryError'
      provider.destroy
      validate_file(expected_content_eight, tmpfile)
    end

    expected_content_nine = <<-JAVAARGS
        JAVA_ARGS="-Xmx256m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
    JAVAARGS
    it 'modifies an existing subsetting' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-Xmx', value: '256m'))
      provider = described_class.new(resource)
      expect(provider.exists?).to eq '192m'
      provider.value = '256m'
      validate_file(expected_content_nine, tmpfile)
    end

    expected_content_ten = <<-JAVAARGS
        JAVA_ARGS="-Xmx192m -XXtest -XXtest"
    JAVAARGS
    it 'is able to modify several subsettings with the same name' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: '-XX', value: 'test'))
      provider = described_class.new(resource)
      expect(provider.exists?).to eq ':+HeapDumpOnOutOfMemoryError'
      provider.value = 'test'
      validate_file(expected_content_ten, tmpfile)
    end
  end

  context 'when working with subsettings in files with unquoted settings values' do
    let(:common_params) do
      {
        title: 'ini_setting_ensure_present_test',
        path: tmpfile,
        section: 'main',
        setting: 'reports'
      }
    end

    let(:orig_content) do
      <<-INIFILE
        [main]

        reports = http,foo
      INIFILE
    end

    expected_content_one = <<-INIFILE
        [main]

        reports = foo
    INIFILE
    it 'removes an existing subsetting' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: 'http', subsetting_separator: ','))
      provider = described_class.new(resource)
      expect(provider.exists?).to eq ''
      provider.destroy
      validate_file(expected_content_one, tmpfile)
    end

    expected_content_two = <<-INIFILE
        [main]

        reports = http,foo,puppetdb
    INIFILE
    it "adds a new subsetting when the 'parent' setting already exists" do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: 'puppetdb', subsetting_separator: ','))
      provider = described_class.new(resource)
      expect(provider.exists?).to be_nil
      provider.value = ''
      validate_file(expected_content_two, tmpfile)
    end

    expected_content_three = <<-INIFILE
        [main]

        reports = http,foo
        somenewsetting = puppetdb
    INIFILE
    it "adds a new subsetting when the 'parent' setting does not already exist" do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(setting: 'somenewsetting', subsetting: 'puppetdb', subsetting_separator: ','))
      provider = described_class.new(resource)
      expect(provider.exists?).to be_nil
      provider.value = ''
      validate_file(expected_content_three, tmpfile)
    end
  end

  context 'when working with subsettings in files with use_exact_match' do
    let(:common_params) do
      {
        title: 'ini_setting_ensure_present_test',
        path: tmpfile,
        section: 'main',
        setting: 'reports',
        use_exact_match: true
      }
    end

    let(:orig_content) do
      <<-INIFILE
        [main]

        reports = http,foo
      INIFILE
    end

    expected_content_one = <<-INIFILE
        [main]

        reports = http,foo,fo
    INIFILE
    it "adds a new subsetting when the 'parent' setting already exists" do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: 'fo', subsetting_separator: ','))
      provider = described_class.new(resource)
      provider.value = ''
      expect(validate_file(expected_content_one, tmpfile)).to be_truthy
    end

    expected_content_two = <<-INIFILE
        [main]

        reports = http,foo
    INIFILE
    it 'does not remove substring subsettings' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: 'fo', subsetting_separator: ','))
      provider = described_class.new(resource)
      provider.value = ''
      provider.destroy
      expect(validate_file(expected_content_two, tmpfile)).to be_truthy
    end
  end

  context 'when working with subsettings in files with subsetting_key_val_separator' do
    let(:common_params) do
      {
        title: 'ini_setting_ensure_present_test',
        path: tmpfile,
        section: 'main',
        setting: 'reports',
        subsetting_separator: ',',
        subsetting_key_val_separator: ':'
      }
    end

    let(:orig_content) do
      <<-INIFILE
        [main]

        reports = a:1,b:2
      INIFILE
    end

    expected_content_one = <<-INIFILE
        [main]

        reports = a:1,b:2,c:3
    INIFILE
    it "adds a new subsetting when the 'parent' setting already exists" do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: 'c', value: '3'))
      provider = described_class.new(resource)
      provider.value = '3'
      expect(validate_file(expected_content_one, tmpfile)).to be_truthy
    end

    expected_content_two = <<-INIFILE
        [main]

        reports = a:1,b:2
        somenewsetting = c:3
    INIFILE
    it "adds a new subsetting when the 'parent' setting does not already exist" do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: 'c', value: '3', setting: 'somenewsetting'))
      provider = described_class.new(resource)
      expect(provider.exists?).to be_nil
      provider.value = '3'
      validate_file(expected_content_two, tmpfile)
    end

    expected_content_three = <<-INIFILE
        [main]

        reports = a:1
    INIFILE
    it 'is able to remove the existing subsetting' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: 'b'))
      provider = described_class.new(resource)
      expect(provider.exists?).to eq '2'
      provider.destroy
      validate_file(expected_content_three, tmpfile)
    end

    expected_content_four = <<-INIFILE
        [main]

        reports = a:1,b:5
    INIFILE
    it 'is able to modify the existing subsetting' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(subsetting: 'b', value: '5'))
      provider = described_class.new(resource)
      expect(provider.exists?).to eq '2'
      provider.value = '5'
      validate_file(expected_content_four, tmpfile)
    end
  end

  context 'when delete_if_empty is toggled to true' do
    let(:common_params) do
      {
        title: 'ini_setting_delete_if_empty_test',
        path: tmpfile,
        section: 'main',
        delete_if_empty: true
      }
    end

    let(:orig_content) do
      <<-INIFILE
        [main]
        reports = http
        something = else
      INIFILE
    end

    expected_content_one = <<-INIFILE
        [main]
        something = else
    INIFILE

    expected_content_two = <<-INIFILE
        [main]
    INIFILE

    it 'removes the subsetting when the it is empty' do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(setting: 'reports', subsetting: 'http', subsetting_separator: ','))
      provider = described_class.new(resource)
      provider.destroy
      expect(validate_file(expected_content_one, tmpfile)).to be_truthy
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(setting: 'something', subsetting: 'else', subsetting_separator: ','))
      provider = described_class.new(resource)
      provider.destroy
      expect(validate_file(expected_content_two, tmpfile)).to be_truthy
    end
  end
end
