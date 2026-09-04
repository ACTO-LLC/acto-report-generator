# Report Generator — md-to-pdf with Fluent MedOps branding
FROM node:20-slim

RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    fonts-noto-color-emoji \
    libgbm1 \
    libnss3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libasound2 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /app

RUN npm install -g md-to-pdf@5.2.5

COPY pdf-config.js /app/
COPY templates/ /app/templates/
COPY entrypoint.sh /app/

RUN sed -i 's/\r$//' /app/entrypoint.sh && chmod +x /app/entrypoint.sh

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/app/entrypoint.sh"]
