# Donn

Docker image which compiles CSS (from SASS) and JS files.

[Docker Hub](https://hub.docker.com/r/druidfi/donn) has variants for Node 16 and 18 (arm64 and amd64).

## Requirements

- You mount your local path (e.g. Drupal theme) to /data in the container.
- Your local path has folder `src/scss` which contains SASS files.
- Your local path has folder `src/js` which contains JavaScript files.

## Tools

- Gulp 4 (https://www.npmjs.com/package/gulp) - Frozen in time as there is no certainty for v5.
- Webpack [In progress]

## Using image in your project

Examples on Drupal project:

```console
docker run -it --rm -v $(pwd)/path/to/theme:/data druidfi/donn:node-18 gulp production
```

```console
docker run -it --rm -v $(pwd)/path/to/theme:/data druidfi/donn:node-18 gulp development
```

```console
docker run -it --rm -v $(pwd)/path/to/theme:/data druidfi/donn:node-18 gulp watch
```

## Using it in druidfi/tools

You can add these to e.g. `tools/make/project/theme.mk` and have `NODE_VERSION=18` in your `.env` file:

```shell
THEME_PATH := $(shell pwd)/$(WEBROOT)/themes/custom/druid_theme

PHONY += drupal-build-theme
drupal-build-theme:
	$(call step,Build theme with Gulp...\n)
	@docker run -it --rm -v $(THEME_PATH):/data druidfi/donn:node-$(NODE_VERSION) gulp production

PHONY += drupal-watch-theme
drupal-watch-theme:
	$(call step,Watch theme with Gulp...\n)
	@docker run -it --rm -v $(THEME_PATH):/data druidfi/donn:node-$(NODE_VERSION) gulp watch
```

## Environment variables

Environment variables (and their default values) which can be used to change configuration:

- `BROWSERSLIST="last 2 version, not dead"`
- `DIST_FOLDER=dist`
- `SRC_FOLDER=src`

## Build images

Locally with M1:

```console
docker buildx bake -f docker-bake.hcl --pull --progress plain --no-cache --load --set "*.platform=linux/arm64"
```

Build and push images to Docker Hub:

```console
docker buildx bake -f docker-bake.hcl --pull --no-cache --push
```

## Where the name "Donn" comes from?

In Irish mythology, Donn ("the dark one", from Proto-Celtic: *Dhuosnos) is an ancestor of the Gaels and is believed to
have been a god of the dead. Donn is said to dwell in Tech Duinn (the "house of Donn" or "house of the dark one"),
where the souls of the dead gather.
