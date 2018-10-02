require 'beaker-pe'
require 'beaker-puppet'
require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'
require 'beaker/i18n_helper'
require 'beaker-task_helper'

run_puppet_install_helper
configure_type_defaults_on(hosts)
install_ca_certs unless ENV['PUPPET_INSTALL_TYPE'] =~ %r{pe}i
install_module_on(hosts)
install_module_dependencies_on(hosts)

RSpec.configure do |c|
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true

  # Readable test descriptions
  c.formatter = :documentation
  c.treat_symbols_as_metadata_keys_with_true_values = true

  c.before :suite do
    run_puppet_access_login(user: 'admin') if pe_install? && (Gem::Version.new(puppet_version) >= Gem::Version.new('5.0.0'))
    hosts.each do |host|
      # This will be removed, this is temporary to test localisation.
      if (fact('osfamily') == 'Debian' || fact('osfamily') == 'RedHat') &&
         (Gem::Version.new(puppet_version) >= Gem::Version.new('4.10.5') &&
          Gem::Version.new(puppet_version) < Gem::Version.new('5.2.0'))
        on(host, 'mkdir /opt/puppetlabs/puppet/share/locale/ja')
        on(host, 'touch /opt/puppetlabs/puppet/share/locale/ja/puppet.po')
      end
      if fact('osfamily') == 'Debian'
        # install language on debian systems
        install_language_on(host, 'ja_JP.utf-8') if not_controller(host)
        # This will be removed, this is temporary to test localisation.
      end
      # Required for binding tests.
      if fact('osfamily') == 'RedHat'
        if fact('operatingsystemmajrelease') =~ %r{7} || fact('operatingsystem') =~ %r{Fedora}
          shell('yum install -y bzip2')
        end
      end
      on host, puppet('module', 'install', 'stahnma/epel')
    end
  end
end
