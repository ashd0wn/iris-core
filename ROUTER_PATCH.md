# iris-core: Router UI Patch Instructions

## Goal

Wire ui.UIHandler() into the HTTP router so that:
- Built with -tags embed: serves UI from embedded binary
- Built without: falls back to CORE_ROUTER_UI_PATH (unchanged)

## Step 1 -- Find the router initialization

Search these files for: UIPath, ui_path, /ui, Static(
- app/api.go
- app/core.go
- http/router/router.go

## Step 2 -- Current UI mounting code (probably looks like this)

Echo framework:
    if len(cfg.Router.UIPath) != 0 {
        e.Static("/ui", cfg.Router.UIPath)
    }

Chi framework:
    if len(cfg.Router.UIPath) != 0 {
        FileServer(r, "/ui", http.Dir(cfg.Router.UIPath))
    }

## Step 3 -- Replace with embed-aware code

Add import:
    irisui "github.com/ashd0wn/iris-core/app/ui"

Replace the block found in Step 2 with:

    if embeddedFS := irisui.UIHandler(); embeddedFS != nil {
        // Embedded mode (-tags embed): serve UI from binary
        e.GET("/ui*", echo.WrapHandler(
            http.StripPrefix("/ui", http.FileServer(embeddedFS)),
        ))
    } else if len(cfg.Router.UIPath) != 0 {
        // Filesystem mode: CORE_ROUTER_UI_PATH (unchanged)
        e.Static("/ui", cfg.Router.UIPath)
    }

Adjust variable names to match the actual router (e, r, router, mux...).
