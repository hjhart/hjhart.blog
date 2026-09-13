FROM node:20-slim

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

RUN apt-get update && apt-get install -y chromium --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /resume
COPY package.json /resume/package.json
COPY package-lock.json /resume/package-lock.json
RUN npm install
