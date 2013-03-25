require 'spec_helper'
require 'puppet'

provider_class = Puppet::Type.type(:ini_subsetting).provider(:ruby)
describe provider_class do
  include PuppetlabsSpec::Files

  let(:tmpfile) { tmpfilename("ini_setting_test") }

  let(:common_params) { {
      :title    => 'ini_setting_ensure_present_test',
      :path     => tmpfile,
      :section  => '',
      :key_val_separator => '=',
      :setting => 'JAVA_ARGS',
  } }

  def validate_file(expected_content,tmpfile = tmpfile)
    File.read(tmpfile).should == expected_content
  end


  before :each do
    File.open(tmpfile, 'w') do |fh|
      fh.write(orig_content)
    end
  end

  context "when ensuring that a subsetting is present" do
    let(:orig_content) {
      <<-EOS
JAVA_ARGS="-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
      EOS
    }

    it "should add a missing subsetting" do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(
         :subsetting => '-Xms', :value => '128m'))
      provider = described_class.new(resource)
      provider.exists?.should be_nil
      provider.create
      validate_file(<<-EOS
JAVA_ARGS="-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof -Xms128m"
      EOS
)
    end

    it "should remove an existing subsetting" do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(
          :subsetting => '-Xmx'))
      provider = described_class.new(resource)
      provider.exists?.should == "192m"
      provider.destroy
      validate_file(<<-EOS
JAVA_ARGS="-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
      EOS
)
    end
    
    it "should modify an existing subsetting" do
      resource = Puppet::Type::Ini_subsetting.new(common_params.merge(
          :subsetting => '-Xmx', :value => '256m'))
      provider = described_class.new(resource)
      provider.exists?.should == "192m"
      provider.value=('256m')
      validate_file(<<-EOS
JAVA_ARGS="-Xmx256m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof"
      EOS
)
    end
    
  end
end
