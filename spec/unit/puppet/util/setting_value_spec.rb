require 'spec_helper'
require 'puppet/util/setting_value'

describe Puppet::Util::SettingValue do

  describe "space subsetting separator" do
    INIT_VALUE_SPACE = "\"-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof\""

    before :each do
      @setting_value = Puppet::Util::SettingValue.new(INIT_VALUE_SPACE, " ")
    end
  
    it "should get the original value" do
      @setting_value.get_value.should == INIT_VALUE_SPACE
    end
   
    it "should get the correct value" do
      @setting_value.get_subsetting_value("-Xmx",'').should == "192m"
    end
  
    it "should add a new value" do
      @setting_value.add_subsetting("-Xms", '', "256m")
      @setting_value.get_subsetting_value("-Xms",'').should == "256m"
      @setting_value.get_value.should == INIT_VALUE_SPACE[0, INIT_VALUE_SPACE.length - 1] + " -Xms256m\""
    end
  
    it "should change existing value" do
      @setting_value.add_subsetting("-Xmx", '', "512m")
      @setting_value.get_subsetting_value("-Xmx",'').should == "512m"
    end
  
    it "should remove existing value" do
      @setting_value.remove_subsetting("-Xmx",'')
      @setting_value.get_subsetting_value("-Xmx",'').should == nil
    end
    
  end

  describe "comma subsetting separator" do
    INIT_VALUE_COMMA = "\"-Xmx192m,-XX:+HeapDumpOnOutOfMemoryError,-XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof\""

    before :each do
      @setting_value = Puppet::Util::SettingValue.new(INIT_VALUE_COMMA, ",")
    end
  
    it "should get the original value" do
      @setting_value.get_value.should == INIT_VALUE_COMMA
    end
   
    it "should get the correct value" do
      @setting_value.get_subsetting_value("-Xmx",'').should == "192m"
    end
  
    it "should add a new value" do
      @setting_value.add_subsetting("-Xms", '', "256m")
      @setting_value.get_subsetting_value("-Xms", '').should == "256m"
      @setting_value.get_value.should == INIT_VALUE_COMMA[0, INIT_VALUE_COMMA.length - 1] + ",-Xms256m\""
    end
  
    it "should change existing value" do
      @setting_value.add_subsetting("-Xmx", '', "512m")
      @setting_value.get_subsetting_value("-Xmx",'').should == "512m"
    end
  
    it "should remove existing value" do
      @setting_value.remove_subsetting("-Xmx",'')
      @setting_value.get_subsetting_value("-Xmx",'').should == nil
    end
  end

  describe "quote_char parameter" do
    QUOTE_CHAR = '"'
    INIT_VALUE_UNQUOTED = '-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof'

    it "should get quoted empty string if original value was empty" do
      setting_value = Puppet::Util::SettingValue.new(nil, ' ', '', QUOTE_CHAR)
      setting_value.get_value.should == QUOTE_CHAR * 2
    end
   
    it "should quote the setting when adding a value" do
      setting_value = Puppet::Util::SettingValue.new(INIT_VALUE_UNQUOTED, ' ', '', QUOTE_CHAR)
      setting_value.add_subsetting("-Xms", '', "256m")

      setting_value.get_subsetting_value("-Xms",'').should == "256m"
      setting_value.get_value.should == QUOTE_CHAR + INIT_VALUE_UNQUOTED + ' -Xms256m' + QUOTE_CHAR
    end
  
    it "should quote the setting when changing an existing value" do
      setting_value = Puppet::Util::SettingValue.new(INIT_VALUE_UNQUOTED, ' ', '', QUOTE_CHAR)
      setting_value.add_subsetting("-Xmx", '', "512m")

      setting_value.get_subsetting_value("-Xmx",'').should == "512m"
      setting_value.get_value.should =~ /^#{Regexp.quote(QUOTE_CHAR)}.*#{Regexp.quote(QUOTE_CHAR)}$/
    end
  
    it "should quote the setting when removing an existing value" do
      setting_value = Puppet::Util::SettingValue.new(INIT_VALUE_UNQUOTED, ' ', '', QUOTE_CHAR)
      setting_value.remove_subsetting("-Xmx",'')

      setting_value.get_subsetting_value("-Xmx",'').should == nil
      setting_value.get_value.should =~ /^#{Regexp.quote(QUOTE_CHAR)}.*#{Regexp.quote(QUOTE_CHAR)}$/
    end
  end
  
  describe "subsetting_val_separator value separator" do
    INIT_VALUE_VAL_SEP = "\"-Xmx192m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/pe-puppetdb/puppetdb-oom.hprof\""

    before :each do
      @setting_value = Puppet::Util::SettingValue.new(INIT_VALUE_VAL_SEP, " ")
    end

    it "should get the original value" do
      @setting_value.get_value.should == INIT_VALUE_VAL_SEP
    end
 
    it "should get a separated value" do 
      @setting_value.get_subsetting_value("-XX:HeapDumpPath","=").should == "/var/log/pe-puppetdb/puppetdb-oom.hprof"
    end

    it "should add a new separated value" do 
      @setting_value.add_subsetting('-XX:MaxPermGen', '=', '256m')
      @setting_value.get_subsetting_value('-XX:MaxPermGen', '=').should == '256m'
      @setting_value.get_value.should == INIT_VALUE_VAL_SEP[0, INIT_VALUE_VAL_SEP.length - 1] + " -XX:MaxPermGen=256m\""
    end
  
    it "should change an existing separated value" do
      @setting_value.add_subsetting("-XX:HeapDumpPath", "=", '/tmp/dumppath')
      @setting_value.get_subsetting_value("-XX:HeapDumpPath", "=").should == '/tmp/dumppath'
    end

    it "should remove an existing separated value" do 
      @setting_value.remove_subsetting("-XX:HeapDumpPath",'=')
      @setting_value.get_subsetting_value("-XX:HeapDumpPath",'=').should == nil
    end
  end
end
