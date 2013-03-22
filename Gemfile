source :rubygems

group :development, :test do
  gem 'puppetlabs_spec_helper', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
  if puppetversion < '3.0.0'
    gem 'hiera-puppet', :require => true
  end
else
  gem 'puppet', :require => false
end
