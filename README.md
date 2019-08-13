# Credits

Jekyll rakefile: https://github.com/avillafiorita/jekyll-rakefile

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
