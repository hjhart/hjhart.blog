# Credits

Jekyll rakefile: https://github.com/avillafiorita/jekyll-rakefile

## Grab resumes

```
hub clone hjhart/resumes
# set up repository, generate resumes
cp ../resume/resume.* resumes/
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
