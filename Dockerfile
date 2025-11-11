# =========================
# Production Stage (Debian 13 "trixie")
# =========================
FROM node:22.21.1-trixie-slim AS runtime
ENV DEBIAN_FRONTEND=noninteractive

# System + app deps (no Chrome deps — Playwright handles those)
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates curl bash openssl \
      ghostscript libopenjp2-7 \
      ffmpeg \
      gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
      gstreamer1.0-plugins-bad gstreamer1.0-nice \
      gstreamer1.0-tools \
      fonts-liberation fonts-dejavu-core \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/api

# Playwright env
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

# Let Playwright handle browser deps + Chromium itself
RUN npx --yes playwright install --with-deps chromium