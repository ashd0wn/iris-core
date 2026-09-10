//go:build embed

package ui

import (
    "embed"
    "io/fs"
    "log"
    "net/http"
)

// dist holds the compiled iris-ui React build.
// Populated at deploy time by build-iris.sh:
//   cp -r ../iris-ui/build/* iris-core/app/ui/dist/
//
//go:embed dist
var dist embed.FS

// uiHandler returns an http.FileSystem backed by the embedded UI files.
func uiHandler() http.FileSystem {
    sub, err := fs.Sub(dist, "dist")
    if err != nil {
        log.Fatalf("[iris] Failed to create embedded UI sub-filesystem: %v", err)
    }
    return http.FS(sub)
}

