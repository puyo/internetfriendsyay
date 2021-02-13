source 'https://rubygems.org'

ruby File.read(File.dirname(__FILE__) + '/.ruby-version').strip

gem 'rails', '~> 4.2.4'

gem 'bigdecimal', '~> 1.4.0' # upgrade requires Rails 5+
gem 'bootstrap-sass'         #
gem 'coffee-rails'           # coffeescript
gem 'haml-rails'             # html templates
gem 'jquery-rails'           # jquery
gem 'jquery-ui-rails'        #
gem 'normalize-rails'        #
gem 'oj'                     # fast json parser
gem 'pg', '~> 0.20'          # database driver, upgrade requires Rails 5.1+
gem 'sass-rails'             # css preprocessor
gem 'schema_plus'            # foreign key constraints and other goodies
gem 'simple_form'            #
gem 'uglifier'               # js compressor

group :production do
  gem 'rails_12factor' # heroku
end

group :test do
  gem 'database_cleaner'                      # manage database truncation/transactions
  gem 'rspec-activemodel-mocks', require: nil #
  gem 'rspec-rails', require: nil             # test framework
  gem 'simplecov', require: nil               #
end

group :development, :test do
  gem 'pry-byebug'   # break on 'binding.pry' in code
  gem 'pry-rails'    # nicer console
  gem 'quiet_assets' # don't log asset pipeline requests
end

group :development do
  gem 'rack-livereload' # transparent livereload client
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :cli do
  gem 'capistrano'           # deploy scripts
  gem 'capistrano_colors'    # coloured output for capistrano
  gem 'foreman'              # handle procfile
  gem 'guard'                # run commands when files change
  gem 'guard-livereload'     # reload the web browser when source files change
  gem 'guard-rspec'          # rerun tests when files change
  gem 'unicorn'              # web server
  gem 'interactive_editor'   # irb interactive editing
  gem 'puma'                 # load balancer and faye friendly web server
  gem 'sdoc', require: false # static documentation generator
end

