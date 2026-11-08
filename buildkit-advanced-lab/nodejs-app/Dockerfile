# syntax=docker/dockerfile:1

FROM node:18-alpine AS base
WORKDIR /app

FROM base AS deps
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm     npm ci --only=production

FROM base AS deps-dev
COPY package.json package-lock.json* ./
RUN --mount=type=cache,target=/root/.npm     npm ci

FROM deps-dev AS build
COPY . .

FROM base AS production
COPY --from=deps /app/node_modules ./node_modules
COPY . .

EXPOSE 3000
CMD ["npm", "start"]
