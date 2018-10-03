require 'spec_helper_acceptance'
require 'beaker/i18n_helper'

describe 'i18n Testing', if: (fact('osfamily') == 'Debian' || fact('osfamily') == 'RedHat') && (Gem::Version.new(puppet_version) >= Gem::Version.new('4.10.5')) do
  before :all do
    hosts.each do |host|
      on(host, "sed -i \"96i FastGettext.locale='ja'\" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb")
      change_locale_on(host, 'ja_JP.utf-8')
    end
  end

  context 'path => foo' do
    pp = <<-EOS
      ini_setting { 'path => foo':
        ensure     => present,
        section    => 'one',
        setting    => 'two',
        value      => 'three',
        path       => 'foo',
      }
    EOS

    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).to match(%r{Ƒīŀḗ ƥȧŧħş ḿŭşŧ ƀḗ ƒŭŀŀẏ ɋŭȧŀīƒīḗḓ, ƞǿŧ})
    end
  end

  after :all do
    hosts.each do |host|
      on(host, 'sed -i "96d" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb')
      change_locale_on(host, 'en_US')
    end
  end
end
