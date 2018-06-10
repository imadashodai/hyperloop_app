# 環境構築

## docker build

```
$ docker-compose build
```

## bundle install

```
$ docker-compose run app bash
# bundle install --path vendor/cache
```

# JSビルド方法

```
$ docker-compose run app bundle exec opal -I. -cOEM src/root.rb > public/js/bundle.js
```
