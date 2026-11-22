# web-api — xray node for Sahabti

Deploy an xray (VLESS + WebSocket) node on Sahabti from this GitHub repo.
Sahabti builds the `Dockerfile`, runs the container, and terminates TLS at its
edge, so xray listens on plain WebSocket on `$PORT`.

## Files

- `Dockerfile` — alpine + xray-core v26.11.9 (downloaded at build time).
- `start.sh` — generates the xray config from env vars and starts xray.

## Deploy (Sahabti)

1. Push these files to a public GitHub repo.
2. In the Sahabti console, create a Web App from that GitHub repo.
3. In the app's environment variables, set:
   - `PORT` — the port Sahabti assigns to the app (e.g. `3000`).
   - `ID` — the VLESS UUID (required; the app refuses to start without it).
   - `WSPATH` — the WebSocket path, e.g. `/vless-xxxxxxxx`.
4. Deploy. Sahabti gives the app a public URL; xray is reachable at
   `https://<your-app-domain><WSPATH>` over VLESS + WS + TLS.

## Security — read this before pushing

- **Do NOT commit a real UUID or WS path into this repo.** The repo is public.
  `ID` and `WSPATH` must only be set as environment variables in the Sahabti
  console, never in a file in the repo. `start.sh` reads them from the
  environment at container start and fails loudly if `ID` is missing.
- The VLESS subscription link (which embeds the UUID) is generated after
  deploy, from the app's public domain + `WSPATH` + `ID`. Keep that link
  private; only share its QR code with people you trust.

## Notes

- Sahabti free tier: web apps deploy from GitHub; free VMs are private-only
  (no public IP), so a VM cannot host a node — use the web-app path above.
- Region is Jordan East (Amman); the exit IP will be in Jordan, not a
  residential line.
- xray logs a WebSocket-deprecated warning on start; it is informational only.
