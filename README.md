<div align="center">

# iris-core

**Go backend for the [Iris](https://github.com/ashd0wn/iris) streaming server**

[![License](https://img.shields.io/badge/license-Apache%202.0-blue?style=flat-square)](LICENSE)
[![Go](https://img.shields.io/badge/Go-1.22-00ADD8?style=flat-square&logo=go)](https://go.dev)
[![Fork](https://img.shields.io/badge/fork-datarhei%2Fcore-gray?style=flat-square)](https://github.com/datarhei/core)

</div>

---

Fork of [datarhei/core](https://github.com/datarhei/core) adapted for bare-metal deployment without Docker.

## Role in the Iris stack

```
iris-core  <-- this repo
|  Orchestrates FFmpeg processes (RTMP, SRT, RTSP, HLS)
|  Exposes REST API + WebSocket (datarhei/core compatible)
|  Serves iris-ui via CORE_ROUTER_UI_PATH
|  Manages HLS storage (memfs) and runtime config
```

Use the deploy script from [iris](https://github.com/ashd0wn/iris) -- do not use standalone.

## Go module

```
module github.com/ashd0wn/iris-core
```

## Build

```bash
# 1. Build iris-ui first
cd ../iris-ui
npm install --legacy-peer-deps
PUBLIC_URL=/ui npm run build

# 2. Copy UI and compile
cd ../iris-core
go mod download
go build -ldflags="-s -w" -o iris-server ./main.go
```

## Environment variables

Only structural variables should be set in the env file.
Everything else (auth, RTMP, SRT, TLS) is configured from the UI.

| Variable                      | Description                              |
|-------------------------------|------------------------------------------|
| `CORE_CONFIGFILE`             | Path to config.json                      |
| `CORE_DB_DIR`                 | Database directory                       |
| `CORE_ROUTER_UI_PATH`         | Path to the React UI build               |
| `CORE_STORAGE_DISK_DIR`       | HLS segments and media storage           |
| `CORE_STORAGE_MIMETYPES_FILE` | Absolute path to mime.types              |
| `CORE_ADDRESS`                | HTTP listen address (format: `:8080`)    |
| `CORE_FFMPEG_BINARY`          | Path to the FFmpeg binary                |
| `CORE_LOG_LEVEL`              | `silent`, `error`, `warn`, `info`, `debug` |

> `CORE_API_AUTH_*`, `CORE_RTMP_*`, `CORE_SRT_*`, `CORE_TLS_*` -- do NOT set these in the env file.
> They lock the fields in the UI. Configure them from the setup wizard on first launch.

## Changes from upstream (datarhei/core)

- Go module renamed to `github.com/ashd0wn/iris-core`
- Docker files removed (`Dockerfile`, `run.sh`, `docker-compose.*`)
- `app/ui/` directory added for go:embed integration (future)
- `build-iris.sh` script for embedded build pipeline (future)
- Iris branding

## API

The API is fully compatible with the upstream datarhei/core API.

Swagger UI: `http://YOUR-IP:PORT/api/swagger/index.html`

## License

Apache License 2.0 -- see [LICENSE](LICENSE)

Upstream: [datarhei/core](https://github.com/datarhei/core)
