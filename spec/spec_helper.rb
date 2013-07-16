gem 'rspec', '>=2.0.0'
require 'rspec/expectations'


require 'puppetlabs_spec_helper/puppetlabs_spec_helper'

require 'puppetlabs_spec_helper/puppetlabs_spec/files'

require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |config|
  config.mock_with :rspec
end
