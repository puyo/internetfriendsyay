# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'fileutils'

InternetFriendsYay::Application.load_tasks

task :deploy do
  sh 'compass compile && jammit -f && git add -f public/assets && git commit -m "Jammit assets" && git push heroku && git reset HEAD^'
end
