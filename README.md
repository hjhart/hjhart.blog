# Credits

Jekyll rakefile: https://github.com/avillafiorita/jekyll-rakefile

## Resume

The resume source of truth is `resumes/resume.json` in this repo. The `hjhart/resume`
repo is archived; this repo is now the source of truth.

### Generate HTML

```
cd resume && docker-compose build && docker-compose run --rm resume ./node_modules/.bin/resume export --theme short resume.html
```

The generated `resumes/resume.html` can then be saved as PDF from Firefox (File → Save as PDF).

### Upload

```
scp resumes/resume.* deploy@hjhart.com:/home/www/hjhart_com/_site/resumes/
```

## Run server

```
docker-compose up
```

## How to deploy

```
docker-compose run --rm app bundle exec cap production deploy:upload_site
```

## Static build

```
docker-compose run --rm app jekyll build
```

## Create a new post

```
docker-compose run --rm app bundle exec rake create_post['title goes here']
```
