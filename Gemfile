source 'https://rubygems.org'

ruby File.read(File.dirname(__FILE__) + '/.ruby-version').strip

gem 'rails', '~> 6.1.0'

gem 'bootsnap', require: false                                     # Reduces boot times through caching; required in config/boot.rb
gem 'geocoder'                                                     # Guess users' timezone
gem 'haml-rails'                                                   # HTML templates
gem 'pg'                                                           # Database driver, upgrade requires Rails 5.1+
gem 'puma', require: nil                                           # Load balancer and faye friendly web server
gem 'simple_form'                                                  # More convenient form methods
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'webpacker'                                                    # Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker

group :development, :test do
  gem 'pry-byebug' # break on 'binding.pry' in code
  gem 'pry-rails'  # nicer console
end

group :test do
  gem 'database_cleaner'                      # Manage database truncation/transactions
  gem 'rspec-rails', require: nil             # Test framework
  gem 'simplecov', require: nil               #
end

group :development do
  gem 'capistrano', require: nil            # deploy scripts
  gem 'capistrano_colors', require: nil     # coloured output for capistrano
  gem 'foreman', require: nil               # handle procfile
  gem 'guard', require: nil                 # run commands when files change
  gem 'guard-livereload', require: nil      # reload the web browser when source files change
  gem 'guard-rspec', require: nil           # rerun tests when files change
  gem 'interactive_editor', require: nil    # irb interactive editing
  gem 'rack-livereload'                     # transparent livereload client
  gem 'rack-mini-profiler'                  # Display performance information such as SQL time and flame graphs for each request in your browser.
  gem 'sdoc', require: nil                  # static documentation generator
  gem 'spring'                              # Cache Rails env for faster cli
  gem 'spring-commands-rspec', require: nil # cached Rails for faster rspec runs
  gem 'spring-watcher-listen', require: nil
  gem 'web-console'                         # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
end
