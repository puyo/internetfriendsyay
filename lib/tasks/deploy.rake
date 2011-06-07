task :deploy do
  # Package assets for production deployment via git push to heroku.
  sh 'bundle exec compass compile'
  sh 'bundle exec jammit -f'
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
