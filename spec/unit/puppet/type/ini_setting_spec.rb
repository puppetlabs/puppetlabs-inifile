#! /usr/bin/env ruby
require 'spec_helper'

ini_setting = Puppet::Type.type(:ini_setting)

describe ini_setting do

  describe "when managing public stuff (default)" do
    before do
      @value = described_class.new(:name => 'foo', :value => 'whatever').property(:value)
    end

    it "should tell us what change is being done" do
      @value.change_to_s('not_secret','at_all').should include('not_secret','at_all')
    end

    it "should tell us current value" do
      @value.is_to_s('not_secret_at_all').should == 'not_secret_at_all'
    end

    it "should tell us new value" do
      @value.should_to_s('not_secret_at_all').should == 'not_secret_at_all'
    end
  end

  describe "when managing secret stuff with keep_secret => md5" do
    before do
      @value = described_class.new(:name => 'foo', :value => 'whatever', :keep_secret => :md5).property(:value)
    end

    it "should tell us md5 hashes of changes being done" do
      @value.change_to_s('not_secret','at_all').should include('e9e8db547f8960ef32dbc34029735564','46cd73a9509ba78c39f05faf078a8cbe')
      @value.change_to_s('not_secret','at_all').should_not include('not_secret')
      @value.change_to_s('not_secret','at_all').should_not include('at_all')
    end

    it "should tell us md5 of current value, but not value itself" do
      @value.is_to_s('not_secret_at_all').should == '{md5}218fde79f501b8ab8d212f1059bb857f'
      @value.is_to_s('not_secret_at_all').should_not include('not_secret_at_all')
    end

    it "should tell us new value" do
      @value.should_to_s('not_secret_at_all').should == '{md5}218fde79f501b8ab8d212f1059bb857f'
      @value.should_to_s('not_secret_at_all').should_not include('not_secret_at_all')
    end
  end

  describe "when managing secret stuff with keep_secret => true" do
    before do
      @value = described_class.new(:name => 'foo', :value => 'whatever', :keep_secret => :true).property(:value)
    end

    it "should tell not tel us values of changes being done" do
      @value.change_to_s('not_secret','at_all').should include('[redacted sensitive information]')
      @value.change_to_s('not_secret','at_all').should_not include('not_secret')
      @value.change_to_s('not_secret','at_all').should_not include('at_all')
    end

    it "should tell us md5 of current value, but not value itself" do
      @value.is_to_s('not_secret_at_all').should == '[redacted sensitive information]'
      @value.is_to_s('not_secret_at_all').should_not include('not_secret_at_all')
    end

    it "should tell us new value" do
      @value.should_to_s('not_secret_at_all').should == '[redacted sensitive information]'
      @value.should_to_s('not_secret_at_all').should_not include('not_secret_at_all')
    end
  end


end
