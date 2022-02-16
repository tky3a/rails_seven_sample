# rails7を使ったサンプルアプリ

# 起動方法

```
docker-compose-build

docker-compose-up

```

# CSS,jsのビルドに失敗した場合

```
# コンテナに入る
docker-compose run app sh

rails javascript:install:esbuild
```