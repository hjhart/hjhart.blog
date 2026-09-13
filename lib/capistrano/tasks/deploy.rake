namespace :deploy do
  task :upload_site do
    run_locally do
      execute 'cd resume && ./node_modules/.bin/resume export --theme short --resume ../resumes/resume.json ../resumes/resume.html'
      execute 'bundle exec jekyll build'
    end
    on roles(:all) do
      upload! '_site/', deploy_path, recursive: true
    end
    on roles(:all) do
      execute "chown deploy:www-data #{deploy_path}/_site"
    end
  end
end
