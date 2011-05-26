# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'fileutils'

InternetFriendsYay::Application.load_tasks

task :deploy do
  sh 'compass compile'
  sh 'jammit -f'
  sh 'git add -f public/assets'
  sh 'git commit -m "Jammit assets"'
  begin
    sh 'git push -f heroku'
  ensure
    sh 'git reset HEAD^'
  end
end
