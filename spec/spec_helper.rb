require 'rspec-puppet-facts'
require 'puppetlabs_spec_helper/module_spec_helper'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

include RspecPuppetFacts
RSpec.configure do |config|
  config.formatter = :documentation
  config.hiera_config = File.join(fixture_path, 'hiera.yaml')
end

at_exit { RSpec::Puppet::Coverage.report! }
