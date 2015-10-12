require 'spec_helper'
describe 'inifile' do

  describe 'with default options' do
    it { should compile.with_all_deps }
    it { should contain_class('inifile') }
  end

  describe 'with parameter ini_settings_hiera_merge' do
    context 'set to an invalid type (non-string and a non-boolean)' do
      let(:params) { { :ini_settings_hiera_merge => ['invalid','type'] } }

      it 'should fail' do
        expect {
          should contain_class('inifile')
        }.to raise_error(Puppet::Error,/\["invalid", "type"\] is not a boolean./)
      end
    end

    ['true',true,'false',false].each do |value|
      context "set to #{value}" do
        let(:params) { { :ini_settings_hiera_merge => value } }

        it { should contain_class('inifile') }
      end
    end
  end

  describe 'with parameter ini_settings' do
    context 'set to an invalid type (non-hash)' do
      let(:params) do
        {
          :ini_settings             => ['invalid','type'],
          :ini_settings_hiera_merge => false,
        }
      end

      it 'should fail' do
        expect {
          should contain_class('inifile')
        }.to raise_error(Puppet::Error,/\["invalid", "type"\] is not a Hash./)
      end
    end

    context 'set to a valid hash' do
      let(:params) { { :ini_settings_hiera_merge => false,
        :ini_settings => {
        'sample setting' => {
          'ensure'  => 'absent',
          'path'    => '/tmp/foo.ini',
          'section' => 'foo',
          'setting' => 'foosetting',
          'value'   => 'FOO!',
        },
        'colorize_git' => {
          'ensure'  => 'present',
          'path'    => '/root/.gitconfig',
          'section' => 'color',
          'setting' => 'ui',
          'value'   => 'auto',
        }
      } } }

      it { should contain_class('inifile') }

      it {
        should contain_ini_setting('sample setting').with({
          'ensure'  => 'absent',
          'path'    => '/tmp/foo.ini',
          'section' => 'foo',
          'setting' => 'foosetting',
          'value'   => 'FOO!',
        })
      }

      it {
        should contain_ini_setting('colorize_git').with({
          'ensure'  => 'present',
          'path'    => '/root/.gitconfig',
          'section' => 'color',
          'setting' => 'ui',
          'value'   => 'auto',
        })
      }
    end
  end

  describe 'with parameter ini_subsettings_hiera_merge' do
    context 'set to an invalid type (non-string and a non-boolean)' do
      let(:params) { { :ini_subsettings_hiera_merge => ['invalid','type'] } }

      it 'should fail' do
        expect {
          should contain_class('inifile')
        }.to raise_error(Puppet::Error,/\["invalid", "type"\] is not a boolean./)
      end
    end

    ['true',true,'false',false].each do |value|
      context "set to #{value}" do
        let(:params) { { :ini_subsettings_hiera_merge => value } }

        it { should contain_class('inifile') }
      end
    end
  end

  describe 'with parameter ini_subsettings' do
    context 'set to an invalid type (non-hash)' do
      let(:params) do
        {
          :ini_subsettings             => ['invalid','type'],
          :ini_subsettings_hiera_merge => false,
        }
      end

      it 'should fail' do
        expect {
          should contain_class('inifile')
        }.to raise_error(Puppet::Error,/\["invalid", "type"\] is not a Hash./)
      end
    end

    context 'set to a valid hash' do
      let(:params) { { :ini_subsettings_hiera_merge => false,
        :ini_subsettings => {
        'sample setting' => {
          'ensure'  => 'absent',
          'path'    => '/tmp/foo.ini',
          'section' => 'foo',
          'setting' => 'foosetting',
          'value'   => 'FOO!',
        },
        'colorize_git' => {
          'ensure'  => 'present',
          'path'    => '/root/.gitconfig',
          'section' => 'color',
          'setting' => 'ui',
          'value'   => 'auto',
        }
      } } }

      it { should contain_class('inifile') }

      it {
        should contain_ini_subsetting('sample setting').with({
          'ensure'  => 'absent',
          'path'    => '/tmp/foo.ini',
          'section' => 'foo',
          'setting' => 'foosetting',
          'value'   => 'FOO!',
        })
      }

      it {
        should contain_ini_subsetting('colorize_git').with({
          'ensure'  => 'present',
          'path'    => '/root/.gitconfig',
          'section' => 'color',
          'setting' => 'ui',
          'value'   => 'auto',
        })
      }
    end
  end
end
