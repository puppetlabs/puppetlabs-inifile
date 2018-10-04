require 'spec_helper_acceptance'
require 'beaker/i18n_helper'
require 'rspec-puppet'
require 'spec_helper'

describe 'i18n Testing', if: (fact('osfamily') == 'Debian' || fact('osfamily') == 'RedHat') && (Gem::Version.new(puppet_version) >= Gem::Version.new('4.10.5')) do
  before :all do
    Puppet::Parser::Functions.autoloader.loadall
    Puppet::Parser::Functions.function(:create_resources)
    hosts.each do |host|
      on(host, "sed -i \"96i FastGettext.locale='ja'\" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb")
      change_locale_on(host, 'ja_JP.utf-8')
    end
  end

  shared_examples 'has_error' do |path, pp, error|
    before :all do
      shell("rm #{path}", acceptable_exit_codes: [0, 1, 2])
    end
    after :all do
      shell("cat #{path}", acceptable_exit_codes: [0, 1, 2])
      shell("rm #{path}", acceptable_exit_codes: [0, 1, 2])
    end

    it 'applies the manifest and gets a failure message' do
      expect(apply_manifest(pp, expect_failures: true).stderr).to match(error)
    end

    describe file(path) do
      it { is_expected.not_to be_file }
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

    it_behaves_like 'has_error', 'foo', pp, %r{Ƒīŀḗ ƥȧŧħş ḿŭşŧ ƀḗ ƒŭŀŀẏ ɋŭȧŀīƒīḗḓ, ƞǿŧ}
  end

  describe 'display interpolated Japanise message' do
    it { is_expected.to run.with_params.and_raise_error(Puppet::ParseError, %r{0 ƒǿř 1 ǿř 2}) }
  end

  after :all do
    hosts.each do |host|
      on(host, 'sed -i "96d" /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb')
      change_locale_on(host, 'en_US')
    end
  end
end
