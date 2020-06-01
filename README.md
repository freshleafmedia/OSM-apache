# Open Street Map Tile Server

## Build

```
docker build .
```

## Run

```
docker run -it --rm -p 80:80 -v /path/to/map/cache:/tileCache freshleafmedia/osm-apache
```

### Environment Variables

There are a couple of environment variables used to configure where the tile renderer is

- `RENDERD_HOST` The renderer hostname
- `RENDERD_PORT` The renderer port number (defaults to `7653`)

### Volumes

- `/tileCache` The tile cache
