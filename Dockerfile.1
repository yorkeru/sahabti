# xray web-api for Sahabti (deploy from GitHub repo)
# Sahabti builds this Dockerfile, runs the container, and terminates TLS at its edge,
# so xray listens on plain WebSocket (no TLS) on $PORT.
FROM alpine:latest
RUN apk add --no-cache wget unzip ca-certificates
WORKDIR /app
COPY start.sh ./
RUN chmod +x start.sh
# Download xray-core at build time so container startup is fast.
RUN wget -q https://github.com/XTLS/Xray-core/releases/download/v26.11.9/Xray-linux-64.zip -O /tmp/xray.zip \
    && unzip -o -q /tmp/xray.zip -d /app/xray \
    && chmod +x /app/xray/xray \
    && rm /tmp/xray.zip
EXPOSE 3000
CMD ["./start.sh"]
