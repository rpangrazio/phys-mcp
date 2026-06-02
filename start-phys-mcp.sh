#!/bin/sh
source ./.venv/bin/activate
#mcpo --port 8000  -- node packages/server/dist/index.js
npx mcp-proxy -- node packages/server/dist/index.js