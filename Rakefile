# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'fileutils'

InternetFriendsYay::Application.load_tasks

task :deploy do
  # Package assets for production deployment via git push to heroku.
  sh 'compass compile'
  sh 'jammit -f'
  sh 'git add -f public/assets'
  sh 'git commit -m "Jammit assets"'
  begin
    # History locally and on heroku are different because of the way we discard
    # the jammit commit, so we need to --force the push.
    sh 'git push -f heroku'
  ensure
    # Discard the jammit commit even if the heroku push failed.
    sh 'git reset HEAD^'
  end
end
