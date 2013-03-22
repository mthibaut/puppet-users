source 'http://rubygems.org'

group :development, :test do
  gem 'puppetlabs_spec_helper', :require => false
  gem 'rspec-hiera-puppet', :require => false
  gem 'hiera', :require => true
  gem 'hiera-puppet', :require => true

end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
  if /^[012]/.match(puppetversion)
    gem 'hiera', :require => true
    gem 'hiera-puppet', :require => true
    gem 'rspec-hiera-puppet'
  end
else
  gem 'puppet', :require => false
end
