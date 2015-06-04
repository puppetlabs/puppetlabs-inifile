require 'spec_helper'
# end-to-end test of the create_init_settings function
describe 'create_ini_settings_test' do
  it { should have_ini_setting_resource_count(3) }
  it { should contain_ini_setting('[section1] setting10').with(
    :ensure  => 'present',
    :section => 'section1',
    :setting => 'setting10',
    :value   => 'val1',
    :path    => '/tmp/foo.ini'
  )}
  it { should contain_ini_setting('[section2] setting20').with(
    :ensure  => 'present',
    :section => 'section2',
    :setting => 'setting20',
    :value   => 'val2',
    :path    => '/tmp/foo.ini'
  )}
  it { should contain_ini_setting('[section2] setting30').with(
    :ensure  => 'absent',
    :section => 'section2',
    :setting => 'setting30',
    :path    => '/tmp/foo.ini'
  )}
end
