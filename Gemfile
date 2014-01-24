source 'https://rubygems.org'

group :development, :test do
  gem 'rake',                   :require => false
  gem 'rspec-puppet',           :require => false
  gem 'puppetlabs_spec_helper', :require => false
  gem 'simplecov',              :require => false
  gem 'pry',                    :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

gem 'puppet-lint', '>= 0.3.2'
gem 'hiera-puppet-helper'

# vim:ft=ruby
