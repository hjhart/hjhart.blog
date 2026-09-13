namespace :deploy do
  task :upload_site do
    run_locally do
      execute 'touch resumes/resume.html'
      execute 'docker-compose -f resume/docker-compose.yml run --rm resume ./node_modules/.bin/resume export --theme short resume.html'
      execute 'docker-compose run --rm app bundle exec jekyll build'
    end
    on roles(:all) do
      upload! '_site/', deploy_path, recursive: true
    end
    on roles(:all) do
      execute "chown deploy:www-data #{deploy_path}/_site"
    end
  end
end
