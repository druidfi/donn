# Donn

[Docker Hub](https://hub.docker.com/repository/docker/druidfi/donn)

In Irish mythology, Donn ("the dark one", from Proto-Celtic: *Dhuosnos) is an ancestor of the Gaels and is believed to
have been a god of the dead. Donn is said to dwell in Tech Duinn (the "house of Donn" or "house of the dark one"),
where the souls of the dead gather.

## Tools

- Gulp 4

## Configuration

Input:

- SCSS files in `/app/src/scss`
- JS files in `/app/src/js`

Output:

- CSS files in `/app/dist/css`
- JS files in `/app/dist/js`

## Using image

```
docker run -it --rm -v $(pwd)/path/to/theme:/app druidfi/donn:node-16 gulp production
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
