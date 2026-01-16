# Report Generator - md-to-pdf with A CTO branding
# Generates professional PDF status reports from markdown

FROM node:20-slim

# Install Chromium dependencies
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

# Set Puppeteer to use installed Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Create app directory
WORKDIR /app

# Install md-to-pdf
RUN npm install -g md-to-pdf

# Copy configuration and templates
COPY pdf-config.js /app/
COPY templates/ /app/templates/
COPY entrypoint.sh /app/

# Fix Windows line endings and make entrypoint executable
RUN sed -i 's/\r$//' /app/entrypoint.sh && chmod +x /app/entrypoint.sh

# Data volume for input/output
VOLUME /data
WORKDIR /data

ENTRYPOINT ["/app/entrypoint.sh"]
