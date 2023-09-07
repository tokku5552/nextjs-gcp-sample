FROM node:18 AS builder

ARG database_url

ENV NODE_ENV=development

ENV DATABASE_URL=$database_url

WORKDIR /app
COPY package.json ./
COPY panda.config.ts ./
COPY postcss.config.cjs ./
COPY yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build


FROM node:18-slim AS runner
ENV NODE_ENV=production

WORKDIR /app
COPY package.json ./
COPY yarn.lock ./

RUN yarn install
COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
CMD ["yarn", "start"]
