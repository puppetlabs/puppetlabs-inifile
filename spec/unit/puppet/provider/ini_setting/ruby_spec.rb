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
        :path     => tmpfile,
        :section  => 'section2',
    } }

    it "should add a missing setting to the correct section" do
      resource = Puppet::Type::Ini_setting.new(common_params.merge(
          :setting => 'yahoo', :value => 'yippee'))
      provider = described_class.new(resource)
      provider.exists?.should == false
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
      resource = Puppet::Type::Ini_setting.new(common_params.merge(
                                                   :setting => 'baz', :value => 'bazvalue2'))
      provider = described_class.new(resource)
      provider.exists?.should == false
      provider.create
      validate_file(<<-EOS
# This is a comment
[section1]
; This is also a comment
foo=foovalue

bar = barvalue
[section2]

foo= foovalue2
baz = bazvalue2
    #another comment
 ; yet another comment
      EOS
      )
    end

    it "should recognize an existing setting with the specified value" do
      resource = Puppet::Type::Ini_setting.new(common_params.merge(
                                                   :setting => 'baz', :value => 'bazvalue'))
      provider = described_class.new(resource)
      provider.exists?.should == true
    end

    it "should add a new section if the section does not exist" do
      resource = Puppet::Type::Ini_setting.new(common_params.merge(
          :section => "section3", :setting => 'huzzah', :value => 'shazaam'))
      provider = described_class.new(resource)
      provider.exists?.should == false
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

[section3]
huzzah = shazaam
      EOS
      )
    end
  end
end
