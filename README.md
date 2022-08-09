# Donn

[Docker Hub](https://hub.docker.com/repository/docker/druidfi/donn)

In Irish mythology, Donn ("the dark one", from Proto-Celtic: *Dhuosnos) is an ancestor of the Gaels and is believed to
have been a god of the dead. Donn is said to dwell in Tech Duinn (the "house of Donn" or "house of the dark one"),
where the souls of the dead gather.

## Requirements

- You mount your local path (e.g. Drupal theme) to /app in the container.
- Your local path has folder `src/scss` which contains SASS files.
- Your local path has folder `src/js` which contains JavaScript files.

## Tools

- Gulp 4

## Using image in your project

Examples on Drupal project:

```
docker run -it --rm -v $(pwd)/path/to/theme:/app druidfi/donn:node-16 gulp production
```

```
docker run -it --rm -v $(pwd)/path/to/theme:/app druidfi/donn:node-16 gulp development
```

```
docker run -it --rm -v $(pwd)/path/to/theme:/app druidfi/donn:node-16 gulp watch
```

## Environment variables

Environment variables (and their default values) which can be used to change configuration:

- `BROWSERSLIST="last 2 version, not dead"`
- `DIST_FOLDER=dist`
- `SRC_FOLDER=src`

## Build images

Locally with M1:

```
docker buildx bake -f docker-bake.hcl --pull --progress plain --no-cache --load --set "*.platform=linux/arm64"
```

Build and push images to Docker Hub:

```
docker buildx bake -f docker-bake.hcl --pull --no-cache --push
```
