# my-app

- ビルドコマンド

```console
cd my-app
docker buildx build \
 --platform linux/amd64 \
 -t <tag> \
 -f ./Dockerfile \
 --push \
 .
```
