require 'spec_helper'
require 'puppet'

provider_class = Puppet::Type.type(:ini_setting).provider(:ruby)
describe provider_class do
  include PuppetlabsSpec::Files


  let(:tmpfile) { tmpfilename("ini_setting_test") }
  let(:orig_content) {
    <<-EOS
# This is a comment
[section1]
; This is also a comment
foo=foovalue

bar = barvalue
[section2]

foo= foovalue2
baz=bazvalue
    #another comment
 ; yet another comment
    EOS
}

  def validate_file(expected_content)
    File.read(tmpfile).should == expected_content
  end


  before :each do
    File.open(tmpfile, 'w') do |fh|
      fh.write(orig_content)
    end
  end

  context "when ensuring that a setting is present" do
    let(:common_params) { {
        :title    => 'ini_setting_ensure_present_test',
        :file     => tmpfile,
        :section  => 'section2',
    } }

    it "should add a missing setting to the correct section" do
      puts "common params (#{common_params.class}:"
      require 'pp'
      pp common_params
      resource = Puppet::Type::Ini_setting.new(common_params.merge(
          :setting => 'yahoo', :value => 'yippee'))
      puts "parse title..."
      pp resource.parse_title
      provider = described_class.new(resource)
      provider.exists?.should be_nil
      provider.create
      validate_file(<<-EOS
# This is a comment
[section1]
; This is also a comment
foo=foovalue

bar = barvalue
[section2]

foo= foovalue2
baz=bazvalue
    #another comment
 ; yet another comment
yahoo = yippee
      EOS
)
    end

    it "should modify an existing setting with a different value" do
      fail
    end

    it "should recognize an existing setting with the specified value and leave it intact" do
      fail
    end
  end
  #it "should pass" do
  #  File.read(@tmpfile).should == orig_content
  #end

  #context "when adding" do
  #  before :each do
  #    #tmp = tmpfilename
  #    #
  #    #@resource = Puppet::Type::File_line.new(
  #    #  {:name => 'foo', :path => @tmpfile, :line => 'foo'}
  #    #)
  #    #@provider = provider_class.new(@resource)
  #  end
  #  it 'should detect if the line exists in the file' do
  #    File.open(@tmpfile, 'w') do |fh|
  #      fh.write('foo')
  #    end
  #    @provider.exists?.should be_true
  #  end
  #  it 'should detect if the line does not exist in the file' do
  #    File.open(@tmpfile, 'w') do |fh|
  #      fh.write('foo1')
  #    end
  #    @provider.exists?.should be_nil
  #  end
  #  it 'should append to an existing file when creating' do
  #    @provider.create
  #    File.read(@tmpfile).chomp.should == 'foo'
  #  end
  #end
  #
  #context "when matching" do
  #  before :each do
  #    # TODO: these should be ported over to use the PuppetLabs spec_helper
  #    #  file fixtures once the following pull request has been merged:
  #    # https://github.com/puppetlabs/puppetlabs-stdlib/pull/73/files
  #    tmp = Tempfile.new('tmp')
  #    @tmpfile = tmp.path
  #    tmp.close!
  #    @resource = Puppet::Type::File_line.new(
  #        {
  #         :name => 'foo',
  #         :path => @tmpfile,
  #         :line => 'foo = bar',
  #         :match => '^foo\s*=.*$',
  #        }
  #    )
  #    @provider = provider_class.new(@resource)
  #  end
  #
  #  it 'should raise an error if more than one line matches, and should not have modified the file' do
  #    File.open(@tmpfile, 'w') do |fh|
  #      fh.write("foo1\nfoo=blah\nfoo2\nfoo=baz")
  #    end
  #    @provider.exists?.should be_nil
  #    expect { @provider.create }.to raise_error(Puppet::Error, /More than one line.*matches/)
  #    File.read(@tmpfile).should eql("foo1\nfoo=blah\nfoo2\nfoo=baz")
  #  end
  #
  #  it 'should replace a line that matches' do
  #    File.open(@tmpfile, 'w') do |fh|
  #      fh.write("foo1\nfoo=blah\nfoo2")
  #    end
  #    @provider.exists?.should be_nil
  #    @provider.create
  #    File.read(@tmpfile).chomp.should eql("foo1\nfoo = bar\nfoo2")
  #  end
  #  it 'should add a new line if no lines match' do
  #    File.open(@tmpfile, 'w') do |fh|
  #      fh.write("foo1\nfoo2")
  #    end
  #    @provider.exists?.should be_nil
  #    @provider.create
  #    File.read(@tmpfile).should eql("foo1\nfoo2\nfoo = bar\n")
  #  end
  #  it 'should do nothing if the exact line already exists' do
  #    File.open(@tmpfile, 'w') do |fh|
  #      fh.write("foo1\nfoo = bar\nfoo2")
  #    end
  #    @provider.exists?.should be_true
  #    @provider.create
  #    File.read(@tmpfile).chomp.should eql("foo1\nfoo = bar\nfoo2")
  #  end
  #end
  #
  #context "when removing" do
  #  before :each do
  #    # TODO: these should be ported over to use the PuppetLabs spec_helper
  #    #  file fixtures once the following pull request has been merged:
  #    # https://github.com/puppetlabs/puppetlabs-stdlib/pull/73/files
  #    tmp = Tempfile.new('tmp')
  #    @tmpfile = tmp.path
  #    tmp.close!
  #    @resource = Puppet::Type::File_line.new(
  #      {:name => 'foo', :path => @tmpfile, :line => 'foo', :ensure => 'absent' }
  #    )
  #    @provider = provider_class.new(@resource)
  #  end
  #  it 'should remove the line if it exists' do
  #    File.open(@tmpfile, 'w') do |fh|
  #      fh.write("foo1\nfoo\nfoo2")
  #    end
  #    @provider.destroy
  #    File.read(@tmpfile).should eql("foo1\nfoo2")
  #  end
  #
  #  it 'should remove the line without touching the last new line' do
  #    File.open(@tmpfile, 'w') do |fh|
  #      fh.write("foo1\nfoo\nfoo2\n")
  #    end
  #    @provider.destroy
  #    File.read(@tmpfile).should eql("foo1\nfoo2\n")
  #  end
  #
  #  it 'should remove any occurence of the line' do
  #    File.open(@tmpfile, 'w') do |fh|
  #      fh.write("foo1\nfoo\nfoo2\nfoo\nfoo")
  #    end
  #    @provider.destroy
  #    File.read(@tmpfile).should eql("foo1\nfoo2\n")
  #  end
  #end
end
