FROM node:16-alpine

WORKDIR /sales

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 5000

CMD ["node", "app.js"]