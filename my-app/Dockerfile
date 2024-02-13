FROM node:20.11.0-alpine as builder

ARG database_url

ENV NODE_ENV=development

ENV DATABASE_URL=$database_url

WORKDIR /app
COPY ./package.json ./
COPY ./panda.config.ts ./
COPY ./postcss.config.cjs ./
COPY ./yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build


FROM node:20.11.0-alpine as runner
ENV NODE_ENV=production

WORKDIR /app

COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000
ENV PORT 3000
ENV HOSTNAME "0.0.0.0"

CMD ["node", "server.js"]
