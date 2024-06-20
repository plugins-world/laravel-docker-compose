FROM node:18-alpine AS builder

RUN pnpm install
RUN pnpm build


FROM nginx:10

COPY --from=builder /path/to/dist /path/to/html
