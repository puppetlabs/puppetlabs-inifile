require 'spec_helper'
require 'spec_helper_acceptance'
require 'beaker/i18n_helper'
require 'pry'

tmpdir = default.tmpdir('tmp')

describe 'i18n Testing', if: (fact('osfamily') == 'Debian' || fact('osfamily') == 'RedHat') && (Gem::Version.new(puppet_version) >= Gem::Version.new('4.10.5')) do
  before :all do
    hosts.each do |host|
      on(host, "sed -i \"96i FastGettext.locale='ja'\" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb")
      change_locale_on(host, 'ja_JP.utf-8')
    end
  end

  context 'display Japanese error' do
    pp = <<-EOS
        ini_subsetting { '-Xmx':
          ensure     => present,
          path       => "#{tmpdir}/ini_subsetting.ini",
          section    => 'java',
          setting    => 'args',
          quote_char => 'test',
          subsetting => '-Xmx',
        }
        EOS

    it 'applies the manifest and gets a failure message - invalid quote_char' do
      expect(apply_manifest(pp, expect_failures: true).stderr).to match(%r{ɋŭǿŧḗ_ƈħȧř ṽȧŀīḓ ṽȧŀŭḗş ȧřḗ '', '"' ȧƞḓ "'"})
    end
  end

  context 'display interpolated Japanese error' do
    pp = <<-EOS
    $settings = {  section1 => {
      setting1 => val1
      },
      section2 => {
        setting2 => val2,
        setting3 => {
          ensure => absent
        }
      }
    }
    $defaults = {
      path => '/tmp/foo.ini'
    }
    create_ini_settings($settings, $defaults, $defaults)
    EOS

    it 'applies the manifest and gets a failure message - wrong number of arguments' do
      apply_manifest(pp, expect_failures: true) do |r|
        expect(r.stderr).to match(%r{Ẇřǿƞɠ ƞŭḿƀḗř ǿƒ ȧřɠŭḿḗƞŧş ɠīṽḗƞ})
      end
    end
  end

  after :all do
    hosts.each do |host|
      on(host, 'sed -i "96d" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb')
      change_locale_on(host, 'en_US')
    end
  end
end
