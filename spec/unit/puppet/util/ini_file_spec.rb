require 'spec_helper'
require 'puppet/util/ini_file'

describe Puppet::Util::IniFile do
  context "when parsing a file" do
    let(:subject) { Puppet::Util::IniFile.new("/my/ini/file/path") }
    let(:sample_content) {
      template = <<-EOS
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
      template.split("\n")
    }

    before :each do
      File.should_receive(:file?).with("/my/ini/file/path") { true }
      described_class.should_receive(:readlines).once.with("/my/ini/file/path") do
        sample_content
      end
    end

    it "should parse the correct number of sections" do
      subject.section_names.length.should == 2
    end

    it "should parse the correct section_names" do
      subject.section_names.should == ["section1", "section2"]
    end

    it "should expose settings for sections" do
      subject.get_value("section1", "foo").should == "foovalue"
      subject.get_value("section1", "bar").should == "barvalue"
      subject.get_value("section2", "foo").should == "foovalue2"
      subject.get_value("section2", "baz").should == "bazvalue"
    end

  end
end