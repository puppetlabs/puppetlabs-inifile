# frozen_string_literal: true

require 'spec_helper'

ini_section = Puppet::Type.type(:ini_section)

describe ini_section do
  describe 'path validation' do
    subject(:ini_section_path) { described_class.new(name: 'foo', path: path) }

    context 'when on posix platforms' do
      before(:each) do
        Puppet.features.stub(:posix?) { true }
        Puppet.features.stub(:microsoft_windows?) { false }
        Puppet::Util::Platform.stub(:windows?) { false }
      end

      context 'with an absolute path' do
        let(:path) { '/absolute/path' }

        it { expect { ini_section_path }.not_to raise_exception }
      end

      context 'with a relative path' do
        let(:path) { 'relative/path' }

        it { expect { ini_section_path }.to raise_exception(Puppet::ResourceError) }
      end
    end

    context 'when on windows platforms' do
      before(:each) do
        Puppet.features.stub(:posix?) { false }
        Puppet.features.stub(:microsoft_windows?) { true }
        Puppet::Util::Platform.stub(:windows?) { true }
      end

      context 'with an absolute path with front slashes' do
        let(:path) { 'c:/absolute/path' }

        it { expect { ini_section_path }.not_to raise_exception }
      end

      context 'with an absolute path with backslashes' do
        let(:path) { 'c:\absolute\path' }

        it { expect { ini_section_path }.not_to raise_exception }
      end

      context 'with an absolute path with mixed slashes' do
        let(:path) { 'c:/absolute\path' }

        it { expect { ini_section_path }.not_to raise_exception }
      end

      context 'with a relative path with front slashes' do
        let(:path) { 'relative/path' }

        it { expect { ini_section_path }.to raise_exception(Puppet::ResourceError) }
      end

      context 'with a relative path with back slashes' do
        let(:path) { 'relative\path' }

        it { expect { ini_section_path }.to raise_exception(Puppet::ResourceError) }
      end
    end
  end

  describe 'when parent of :path is in the catalog' do
    ['posix', 'windows'].each do |platform|
      context "when on #{platform} platforms" do
        before(:each) do
          Puppet.features.stub(:posix?) { platform == 'posix' }
          Puppet.features.stub(:microsoft_windows?) { platform == 'windows' }
          Puppet::Util::Platform.stub(:windows?) { platform == 'windows' }
        end

        let(:file_path) { (platform == 'posix') ? '/tmp' : 'c:/tmp' }
        let(:file_resource) { Puppet::Type.type(:file).new(name: file_path) }
        let(:ini_section_resource) { described_class.new(name: 'foo', path: "#{file_path}/foo.ini") }
        let(:auto_req) do
          catalog = Puppet::Resource::Catalog.new
          catalog.add_resource(file_resource)
          catalog.add_resource(ini_section_resource)

          ini_section_resource.autorequire
        end

        it 'creates relationship' do
          expect(auto_req.size).to be 1
        end

        it 'links to ini_section resource' do
          expect(auto_req[0].target).to eq(ini_section_resource)
        end

        it 'autorequires parent directory' do
          expect(auto_req[0].source).to eq(file_resource)
        end
      end
    end
  end
end
