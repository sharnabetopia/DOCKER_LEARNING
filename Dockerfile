FROM node:20-alpine

WORKDIR /user/src/app

COPY package.json package-lock.json* ./
RUN npm ci --omit=dev

COPY . .
EXPOSE 5000
CMD ["node","index.js"]
