# frozen_string_literal: true

require 'spec_helper'

describe 'create_multiple_ini_settings' do
  context 'on a non-Windows platform', if: !Puppet::Util::Platform.windows? do
    let(:facts) do
      { 'os' => { 'family'  => 'RedHat',
                  'release' => { 'major' => '7',
                                 'minor' => '1',
                                 'full'  => '7.1.1503' } } }
    end

    it { is_expected.to compile }
    it { is_expected.to have_ini_setting_resource_count(2) }

    it {
      is_expected.to contain_ini_setting('/tmp/foo.ini [section1] setting1').with(
        ensure: 'present',
        section: 'section1',
        setting: 'setting1',
        value: 'value1',
        path: '/tmp/foo.ini',
      )
    }
    it {
      is_expected.to contain_ini_setting('/tmp/foo.ini [section1] setting2').with(
        ensure: 'absent',
        section: 'section1',
        setting: 'setting2',
        path: '/tmp/foo.ini',
      )
    }
  end

  context 'on a Windows platform', if: Puppet::Util::Platform.windows? do
    let(:facts) do
      { 'os' => { 'family' => 'windows' } }
    end

    it { is_expected.to compile }
  end
end
