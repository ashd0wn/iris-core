//go:build !embed

package ui

import "net/http"

// uiHandler returns nil in filesystem mode.
// The router will use CORE_ROUTER_UI_PATH instead.
func uiHandler() http.FileSystem {
    return nil
}

