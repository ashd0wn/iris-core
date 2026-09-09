package ui

import "embed"

// Files holds the compiled iris-ui React build embedded in the binary.
// Populated at deploy time by deploy.sh:
//   cp -r ../iris-ui/build/* iris-core/app/ui/
//
//go:embed all:dist
var Files embed.FS

