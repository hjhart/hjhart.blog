FROM node:20-slim

ENV PUPPETEER_SKIP_DOWNLOAD=true

WORKDIR /resume
COPY package.json /resume/package.json
COPY package-lock.json /resume/package-lock.json
RUN npm install
