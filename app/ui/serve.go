// Package ui provides the web interface for Iris.
// Build with -tags embed to embed the UI into the binary.
// Without the tag, the UI is served from CORE_ROUTER_UI_PATH.
package ui

import "net/http"

// UIHandler returns the http.FileSystem for the Iris web UI.
// Returns nil when the embedded UI is not compiled in (filesystem mode).
func UIHandler() http.FileSystem {
    return uiHandler()
}

