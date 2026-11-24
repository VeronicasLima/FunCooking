FROM node:24-bookworm-slim

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

EXPOSE 8100

CMD ["npx", "ng", "serve", "--host", "0.0.0.0", "--port", "8100", "--poll", "2000"]