# syntax=docker/dockerfile:1

FROM node:latest as base

WORKDIR /app

COPY package.json package.json
COPY package-lock.json package-lock.json

FROM base as test
ENV NODE_ENV=TEST
RUN npm ci
COPY . .
RUN npm run test

FROM base as prod
ENV NODE_ENV=production
RUN npm ci --production
COPY . .
CMD [ "node", "server.js" ]

