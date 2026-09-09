# iris-core

Go backend for the [Iris](https://github.com/ashd0wn/iris) project.
Fork of [datarhei/core](https://github.com/datarhei/core).

## Role

- Orchestrates FFmpeg processes (RTMP, SRT, RTSP, HLS)
- Exposes REST API (datarhei/core compatible)
- Embeds iris-ui via go:embed
- Manages HLS storage (memfs) and configuration

Do not use standalone -- use the deploy script from iris.

## Build (automated by deploy.sh)

cp -r ../iris-ui/build/* app/ui/
go mod download
go build -ldflags="-s -w" -o iris-server ./main.go

## Go module

module github.com/ashd0wn/iris-core

## Changes from upstream

- Module renamed (github.com/ashd0wn/iris-core)
- UI embedded via go:embed (no CORE_ROUTER_UI_PATH)
- Docker removed (Dockerfile, run.sh deleted)
- Iris branding

