namespace :cover_me do
  task :report do
    require 'cover_me'
    CoverMe.complete!
  end
end

task :cov => [:test, 'cover_me:report']
