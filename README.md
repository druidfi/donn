# Donn

In Irish mythology, Donn ("the dark one", from Proto-Celtic: *Dhuosnos) is an ancestor of the Gaels and is believed to
have been a god of the dead. Donn is said to dwell in Tech Duinn (the "house of Donn" or "house of the dark one"),
where the souls of the dead gather.

## Tools

- Gulp 4

## Configuration

Input:

- SCSS files in `/app/src/scss`

Output:

- CSS files in `/app/dist/css`

## Using image

```
docker run -it --rm -v $(pwd)/path/to/theme:/app druidfi/donn:node-16 --version
```

## Build images

Locally with M1

```
docker buildx bake -f docker-bake.hcl --pull --progress plain --no-cache --load --set "*.platform=linux/arm64"
```
