FROM node:22-bullseye

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
COPY .env.local .env.local

EXPOSE 3000

CMD ["npm", "run", "dev"]
