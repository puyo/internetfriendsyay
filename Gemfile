source 'https://rubygems.org'

ruby File.read(File.dirname(__FILE__) + '/.tool-versions').match(/ruby (\S+)/).captures.first

gem 'rails', '~> 7.0.2', '>= 7.0.2.2'

gem 'bootsnap', require: false                                  # Reduces boot times through caching; required in config/boot.rb
gem 'bootstrap'                                                 # CSS framework
gem 'importmap-rails'                                           # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'pg', '~> 1.1'                                              # Use postgresql as the database for Active Record
gem 'puma', '~> 5.0'                                            # Use the Puma web server [https://github.com/puma/puma]
gem 'sassc-rails'                                               # Use Sass to process CSS
gem 'simple_form'                                               # form helpers
gem 'sprockets-rails'                                           # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'geocoder', '~> 1.7'                                        # Guess users' timezone

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'
end

group :test do
  gem 'rspec-rails'
  gem 'simplecov', require: nil               #
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
