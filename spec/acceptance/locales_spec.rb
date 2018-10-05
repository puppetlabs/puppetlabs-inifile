require 'spec_helper'
require 'spec_helper_acceptance'
require 'beaker/i18n_helper'
require 'pry'

describe 'i18n Testing', if: (fact('osfamily') == 'Debian' || fact('osfamily') == 'RedHat') && (Gem::Version.new(puppet_version) >= Gem::Version.new('4.10.5')) do
  before :all do
    hosts.each do |host|
      on(host, "sed -i \"96i FastGettext.locale='ja'\" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb")
      change_locale_on(host, 'ja_JP.utf-8')
    end
  end

  shared_examples 'has_error' do |path, pp, error|
    before :all do
      if Dir.exists?(path)
        shell("rm #{path}", acceptable_exit_codes: [0, 1, 2])
      end
    end
    after :all do
      shell("cat #{path}", acceptable_exit_codes: [0, 1, 2])
      shell("rm #{path}", acceptable_exit_codes: [0, 1, 2])
    end

    it 'applies the manifest and gets a failure message' do
      expect(apply_manifest(pp, expect_failures: true).stderr).to match(error)
    end
  end

  context 'display Japanese error' do
    pp = <<-EOS
      ini_setting { 'path => foo':
        ensure     => present,
        section    => 'one',
        setting    => 'two',
        value      => 'three',
        path       => 'foo',
      }
      EOS

    it_behaves_like 'has_error', 'foo', pp, %r{Ƒīŀḗ ƥȧŧħş ḿŭşŧ ƀḗ ƒŭŀŀẏ ɋŭȧŀīƒīḗḓ, ƞǿŧ}
  end

  context 'display interpolated Japanese error' do
    pp = <<-EOS
      ini_setting { 'path => test':
        ensure     => present,
        section    => 'section',
        setting    => 'setting',
        value      => 'three',
        path       => 'test',
      }
      EOS

    it 'displays Japanese failure' do
      apply_manifest(pp, expect_failures: true) do |r|
        expect(r.stderr).to match(%r{Ƒīŀḗ ƥȧŧħş ḿŭşŧ ƀḗ ƒŭŀŀẏ ɋŭȧŀīƒīḗḓ, ƞǿŧ 'test'})
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
