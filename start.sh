#!/bin/sh
# Start xray (VLESS + WebSocket) from environment variables.
# Required env vars (set them in the Sahabti console, NOT in this repo):
#   ID      - VLESS UUID (required, no default)
#   WSPATH  - WebSocket path, e.g. /vless-xxxxxxxx (default /)
#   PORT    - listen port (default 3000; set it to the port Sahabti assigns)
set -e
PORT=${PORT:-3000}
WSPATH=${WSPATH:-/}
if [ -z "$ID" ]; then
  echo "ERROR: ID env var (VLESS UUID) is required. Set it in the Sahabti console." >&2
  exit 1
fi
cat > /app/xray/config.json <<EOF
{
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "clients": [{ "id": "$ID", "flow": "" }],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "$WSPATH" }
      }
    }
  ],
  "outbounds": [{ "protocol": "freedom" }]
}
EOF
echo "Starting xray on port $PORT, ws path $WSPATH"
exec /app/xray/xray run -c /app/xray/config.json
