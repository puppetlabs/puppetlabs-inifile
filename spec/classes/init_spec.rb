require 'spec_helper'

describe 'inifile' do
  let(:facts) { { :fqdn => 'foo.example.com' } }

  describe 'with parameter hiera_merge' do
    context 'set to an invalid type (non-string and a non-boolean)' do
      it 'should fail' do
        expect {
          should raise_error(Puppet::Error)
        }
      end
    end

    ['true',true,'false',false].each do |value|
      context "set to #{value}" do

        it 'should not fail' do
          expect {
            should_not raise_error(Puppet::Error)
          }
        end
      end
    end
  end

  describe 'with parameter ini_settings' do
    context 'set to an invalid type (non-hash)' do
      it 'should fail' do
        expect {
          should raise_error(Puppet::Error)
        }
      end
    end

    context 'set to a valid hash' do
      context 'and hiera_merge set to true' do
        let(:params) { { :hiera_merge => true } }

        include_context 'hieradata'

        it {
          should contain_ini_setting('common_setting').with({
            'ensure' => 'present',
            'path'    => '/tmp/foo.ini',
            'section' => 'global',
            'setting' => 'foosetting',
            'value'   => 'FOO',
          })
        }

        it {
          should contain_ini_setting('fqdn_setting').with({
            'ensure' => 'present',
            'path'    => '/tmp/foo.ini',
            'section' => 'node',
            'setting' => 'foo',
            'value'   => 'bar',
          })
        }
      end

      context 'and hiera_merge set to false' do
        let(:params) { { :hiera_merge => false } }

        include_context 'hieradata'

        it {
          should_not contain_ini_setting('common_setting').with({
            'ensure' => 'present',
            'path'    => '/tmp/foo.ini',
            'section' => 'global',
            'setting' => 'foosetting',
            'value'   => 'FOO',
          })
        }

        it {
          should contain_ini_setting('fqdn_setting').with({
            'ensure' => 'present',
            'path'    => '/tmp/foo.ini',
            'section' => 'node',
            'setting' => 'foo',
            'value'   => 'bar',
          })
        }
      end
    end
  end

  describe 'with parameter ini_subsettings' do
    context 'set to an invalid type (non-hash)' do
      it 'should fail' do
        expect {
          should raise_error(Puppet::Error)
        }
      end
    end
  end
end
